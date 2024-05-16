<template>
  <div id="cxxsew-contents">
    <h1>- Let's Get Our Works -</h1>
    <p>商品購入ページ</p>
    <div class="work-box">
        <div>
            title: {{ work.title }}
            <span v-if="work.onlyone"> ◆ </span>
        </div>
        <div id="work-tshirt-img-wrap">
            <img src="@/assets/images/tshirt.jpeg" alt="">
            <img v-if="work.image" :src="imageUrl(work.image.url)" :alt="work.title"/>
        </div>
        <div class="price">price: ¥{{ work.price != null ? work.price.toLocaleString() : '' }}</div>
        <p>{{ work.text }}</p>
        <!-- <p class="anno">※ 当ブランドの作品であることの証明としてNFTのQRコードをタグにプリントします。</p>
        <p class="anno none">※ 注文時に、自分へのメッセージとして「人生の目的」または「直近の目標」のご記入をおすすめしています。メッセージはタグにプリントされます。</p> -->
        <form @submit.prevent="addToCart(work, 1)">
            <button v-if="work.status === 'soldout'" class="btn" id="soldout" disabled>SOLD OUT</button>
            <button v-else-if="work.onlyone || isWorkInCart(work.id)" class="btn" id="soldout" disabled>選択済み</button>
            <button v-else class="btn" id="submit-btn">カートに追加</button>
        </form>
    </div>
    <div class="selected-container" id="cart-container">
        <p v-if="cartWorks.length == 0" class="total">現在、カートは空です。</p>
        <template v-else>
            <p class="total">カート状況</p>
            <p>{{ totalQuantity }}点の商品が選択されています。</p>
            <div v-for="cartWork in cartWorks" :key="cartWork.id" class="inner-container cart-inner">
                <div class="selected-item">
                    <div class="selected-wrapper">
                    <div class="selected">
                        <div>
                        <p>title: {{ cartWork.title }}</p>
                        <p>price: {{ cartWork.price.toLocaleString() }}</p>
                        <p>数量: <input type="number" class="item-quantity" min="0" max="20" :value="cartWork.quantity" @change="handleQuantityInput(cartWork, $event)"> 点</p>
                        </div>
                        <img :src="imageUrl(cartWork.image.url)" :alt="''"/>
                    </div>
                    </div>
                    <div @click="removeFromCart(cartWork.cart_work_id)" class="bin-wrap">
                        <img src="@/assets/images/bin.jpg" class="bin" alt=""/>
                    </div>
                </div>
            </div>
            <p class="total">合計金額: {{ totalPrice.toLocaleString() }}円</p>
        </template>
    </div>
    <div v-if="cartWorks" class="btn">
        <a href="/cxxsew/purchase">購入確認画面へ</a>
    </div>
    <div class="btn">
        <a href="/cxxsew/works">商品一覧に戻る</a>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { Work, CartWork } from '@/types/work';

export default defineComponent({
    name: 'WorksShow',
    data() {
        return {
            work: {} as Work,
            works: [] as Work[],
            cartWorks: [] as CartWork[],
            cartWorkCheck: false,
        };
    },
    props: {
        id: String,
    },
    mounted() {
        this.fetchWorks();
        this.fetchWorksShow();
        if (this.$isLoggedIn()) {
            this.fetchCartWorks();
        } else {
            this.localCartWorks();
        }
    },
    computed: {
        totalPrice(): number {
            if (!this.cartWorks || this.cartWorks.length === 0) {
                return 0; // カートが空の場合は0を返す
            }
            return this.cartWorks.reduce((total, work) => {
                return total + (work.price * work.quantity); // 価格と数量を掛けて合計に加算
            }, 0); // 初期値は0    
        },
        totalQuantity(): number {
            return this.cartWorks.reduce((sum, item) => {
                return sum + item.quantity;
            }, 0);
        },
    },
    methods: {
        isWorkInCart(workId: number) {
            return this.cartWorks.some(cartWork => cartWork.id === workId);
        },
        handleQuantityInput(cartWork: CartWork, event: Event) {
            const min = 1;
            const max = 20;

            // イベントターゲットがHTMLInputElementであることを確認
            const target = event.target as HTMLInputElement | null;

            if (target === null) {
                return;
            }

            let quantity = parseInt(target.value, 10);

            if (isNaN(quantity) || quantity < min) {
                alert(`最小値は${min}です。`);
                quantity = min;
            } else if (quantity > max) {
                alert(`最大値は${max}です。`);
                quantity = max;
            }

            
            cartWork.quantity = quantity;
            target.value = quantity.toString();
            // cartWorks配列を新しい配列で置き換える
            this.cartWorks = [...this.cartWorks];

            if (this.$isLoggedIn()) {
                this.updateCartWorkQuantity(cartWork.cart_work_id, quantity)
            } else {
                // ローカルストレージを更新
                const cart = this.cartWorks;
                localStorage.setItem('cart', JSON.stringify(cart));
            }
        },
        async fetchWorks() {
            try {
                const response = await this.$api.get<Work[]>('/works');
                this.works = response.data;
            } catch (error) {
                console.error(error);
            }
        },
        async fetchWorksShow() {
            try {
                const response = await this.$api.get<Work>(`/works/${this.id}`);
                this.work = response.data;
            } catch (error) {
                console.error(error);
            }
        },
        async fetchCartWorks() {
            try {
                const response = await this.$api.get<CartWork[]>('/cart_works', {
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                this.cartWorks = response.data;
            } catch (error) {
                console.error(error);
            }
        },
        localCartWorks() {
            const cartStr = localStorage.getItem('cart');
            let cart = cartStr ? JSON.parse(cartStr) : [];
            this.cartWorks = cart;
        },
        addToCart(work: Work, quantity: number) {
            if (this.$isLoggedIn()) {
                this.addProductToServerCart(work, quantity);
            } else {
                this.addProductToLocalCart(work, quantity);
            }
        },
        removeFromCart(cartWorkId: number) {
            if (this.$isLoggedIn()) {
                this.removeFromServerCart(cartWorkId);
            } else {
                this.removeFromLocalCart(cartWorkId);
            }
        },
        async addProductToServerCart(work: Work, quantity: number) {
            try {
                const response = await this.$api.post('/cart_works',
                    {
                        work_id: work.id,
                        quantity: quantity
                    },
                    {
                        headers: {
                            Authorization: `Bearer ${this.$getAuthToken()}`
                        }
                    }
                );
                console.log('カートに追加されました:', response.data);
                this.fetchCartWorks(); // サーバーのカートを更新後、再フェッチ
            } catch (error) {
                console.error('カート追加エラー:', error);
            }
        },
        async updateCartWorkQuantity(cartWorkId: number, quantity: number) {
            try {
                const response = await this.$api.patch(`/cart_works/${cartWorkId}`, {
                    quantity: quantity
                }, {
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                console.log('カートの数量が更新されました:', response.data);
                this.fetchCartWorks(); // サーバーのカートを更新後、再フェッチ
            } catch (error) {
                console.error('カートの数量更新エラー:', error);
            }
        },
        addProductToLocalCart(work: Work, quantity: number) {
            const cartStr = localStorage.getItem('cart');
            let cart = cartStr ? JSON.parse(cartStr) : []; // cartStrがnullでない場合のみJSON.parseを実行

            // 最後のカートアイテムのIDから次のIDを生成
            const lastItem = cart[cart.length - 1];
            const nextCartWorkId = lastItem ? lastItem.cartWorkId + 1 : 1;  // カートが空の場合は1から開始

            let newItem: CartWork = {
                id: work.id,
                work_cat_id: work.work_cat_id,
                title: work.title,
                image: work.image,
                price: work.price,
                text: work.text,
                onlyone: work.onlyone,
                status: work.status,
                cart_work_id: nextCartWorkId,
                quantity: quantity,
            };
            cart.push(newItem);
            this.cartWorks = cart;
            localStorage.setItem('cart', JSON.stringify(cart));
            console.log('ローカルカートに商品が追加されました');
        },
        async removeFromServerCart(cartWorkId: number) {
            try {
                const response = await this.$api.delete(`/cart_works/${cartWorkId}`,{
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                console.log('カートのアイテムが削除されました:', response.data);
                this.fetchCartWorks(); // サーバーのカートを更新後、再フェッチ
            } catch (error) {
                console.error('カートのアイテム削除エラー:', error);
            }
        },
        removeFromLocalCart(cartWorkId: number) {
            const cartStr = localStorage.getItem('cart');
            let cart: CartWork[] = cartStr ? JSON.parse(cartStr) : [];

            // IDに基づいてアイテムをフィルタリングして削除
            cart = cart.filter(item => item.cart_work_id !== cartWorkId);
            this.cartWorks = cart;

            localStorage.setItem('cart', JSON.stringify(cart));
            console.log(`ローカルカートから商品が削除されました: ${cartWorkId}`);
        },
        imageUrl(url: string): string {
            return this.$baseURL + url;
        },
    }
});
</script>