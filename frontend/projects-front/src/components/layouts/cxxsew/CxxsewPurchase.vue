<template>
<div id="cxxsew-contents">
    <h1>- Confirm -</h1>
    <p>カートの内容をご確認ください。「決済」ボタンで商品の購入手続きが完了します。</p>
    <div class="work-box" id="purchase-box">
        <div id="cart-title">
            <img src="@/assets/images/cart.png" alt="" />
            <p>Check your cart</p>
        </div>
        <div v-if="!cartWorks">
            <p class="center">カートは空です。</p>
        </div>
        <div v-else>
            <p>{{ cartWorks.length }}点の商品が選択されています。</p>
            <div class="selected-container">
                <div v-for="cartWork in cartWorks" :key="cartWork.id" class="inner-container">
                    <div class="selected-item">
                        <div class="selected-wrapper">
                            <div class="selected">
                                <div>
                                    <p>title: {{ cartWork.title }}</p>
                                    <!-- <p>type: {{ cartWork.onlyone ? 'オリジナル（一点物）' : 'ノーマル' }}</p> -->
                                    <p>price: ¥{{ cartWork.price.toLocaleString() }}</p>
                                    <p>message: なし</p>
                                </div>
                                <img :src="$baseURL + cartWork.image.url" alt="" />
                            </div>
                        </div>
                        <div @click="removeFromCart(cartWork.cart_work_id)" class="bin-wrap">
                            <img src="@/assets/images/bin.jpg" class="bin" alt=""/>
                        </div>
                    </div>
                    <div class="btn add-msg none">自分へのメッセージを追加</div>
                </div>
                <p class="total">合計金額: {{ totalPrice.toLocaleString() }}円</p>
            </div>
        </div>
        <div v-if="cartWorks.length > 0" class="btn" id="submit-btn">
            <a @click="pay">決済</a>
        </div>
        <p>※ポートフォリオのため、決済ボタンを押しても決済はされません。カートを空にしてThanksページが表示されます。</p>
        <div class="btn" id="submit-btn">
            <a href="/cxxsew/works">商品一覧に戻る</a>
        </div>
    </div>
</div>
</template>


<script lang="ts">
import { defineComponent } from 'vue';
import type { CartWork } from '@/types/work';

export default defineComponent({
    name: 'WorksList',
    data() {
        return {
                cartWorks: [] as CartWork[],
        };
    },
    created() {
    },
    mounted() {
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
    },
    methods: {
        async fetchCartWorks() {
            try {
                const response = await this.$api.get<CartWork[]>('/cart_works', {
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                this.cartWorks = response.data;
                console.log(this.cartWorks);
            } catch (error) {
                console.error(error);
            }
        },
        localCartWorks() {
            const cartStr = localStorage.getItem('cart');
            let cart = cartStr ? JSON.parse(cartStr) : [];
            this.cartWorks = cart;
        },
        imageUrl(url: string): string {
            return this.$baseURL + url;
        },
        removeFromCart(cartWorkId: number) {
            if (this.$isLoggedIn()) {
                this.removeFromServerCart(cartWorkId);
            } else {
                this.removeFromLocalCart(cartWorkId);
            }
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
        async pay() {
            try {
                if (this.$isLoggedIn()) {
                    // サーバーにカートの支払い処理を要求
                    const response = await this.$api.post('/cart_works/pay', {
                        headers: {
                            Authorization: `Bearer ${this.$getAuthToken()}`
                        }
                    });
                    console.log('支払い処理が成功しました。', response.data);
                } else {
                    // ローカルストレージのカートを削除
                    localStorage.removeItem('cart');
                    console.log('ローカルカートがリセットされました。');
                }
                // 支払い処理が成功したらサンクスページへ遷移
                this.$router.push('/cxxsew/thanks');
            } catch (error) {
                console.error('支払い処理中にエラーが発生しました:', error);
            }
        },
    },
});
</script>
