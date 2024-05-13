<template>
<LoginHeader :show-login-btn="showLoginBtn"/>
<main>
    <div v-if="$isLoggedIn()" class="contents">
        <h1>- ログインしています -</h1>
        <a href="/" class="btn block">トップページへ</a>
    </div>
    <div v-else id="login-con" class="contents">
        <h1>- Log in -</h1>
        <!-- <div id="flash">{{ alert }}</div> -->
        <p>ログインすると、Portfolio内の全てのサービスで、アカウントにひもづくデータの保存が可能になります。</p>
        <div id="guest-login-wrapper">
            <p class="center marker">ポートフォリオ閲覧用のゲストログインボタンはこちらです。</p>
            <form @submit.prevent="loginAsGuest">
                <button type="submit" class="btn submit-btn">Guest Log in</button>
            </form>
        </div>
        <form @submit.prevent="login">
            <label for="email">メールアドレス</label>
            <input v-model="credentials.email" type="email" id="email" name="email" placeholder="メールアドレスを入力してください" required />
            <label for="password">パスワード</label>
            <input v-model="credentials.password" type="password" id="password" name="password" placeholder="パスワードを入力してください" required />
            <button type="submit" class="btn submit-btn">Log in</button>
            <div class="btn sub-btn">
            <a href="/users/password_reset">Forget Password?</a>
            </div>
            <div class="btn sub-btn">
            <a href="/users/new">アカウント作成</a>
            </div>
        </form>
    </div>
</main>
<LoginFooter/>
</template>
  
<script lang="ts">
import { defineComponent } from 'vue';
import { AxiosError } from 'axios';
import LoginHeader from '../../components/layouts/login/LoginHeader.vue';
import LoginFooter from '../../components/layouts/login/LoginFooter.vue';

export default defineComponent({
    name: 'LogIn',
    data() {
        return {
            credentials: {
                email: '',
                password: '',
                guest: false,
            },
            showLoginBtn: false,
            // alert: '<%= flash[:alert] %>'
        }
    },
    components: {
        LoginHeader,
        LoginFooter,
    },
    mounted() {
        this.showLoginBtn = this.$isLoggedIn();
    },
    methods: {
        async login() {
            try {
                const response = await this.$api.post('/login', this.credentials);
                await this.handleLoginSuccess(response.data.jwt);
            } catch (error) {
                this.handleLoginError(error);
            }
        },
        async loginAsGuest() {
            this.credentials.guest = true;
            await this.login();
        },
        async handleLoginSuccess(token: string) {
            if (!token) throw new Error("Token not provided in the response");
            localStorage.setItem('authToken', token);
            this.$api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
            await this.syncCartWithServer();
            this.$router.push('/');
        },
        handleLoginError(error: unknown) {
            if (error instanceof AxiosError) {
                console.error('Request failed with status code:', error.response?.status);
            } else {
                console.error('An unknown error occurred:', error);
            }
        },
        async loadLocalStorageCart() {
            const cartStr = localStorage.getItem('cart');
            if (cartStr) {
                return JSON.parse(cartStr);
            }
            return [];
        },
        async syncCartWithServer() {
            const localCart = await this.loadLocalStorageCart();
            if (localCart.length > 0) {
                try {
                    const response = await this.$api.post('/cart_works/sync', { cart: localCart }, {
                        headers: {
                            Authorization: `Bearer ${this.$getAuthToken()}`
                        }
                    });
                    if (response.status === 200) {
                        console.log('Cart synced successfully');
                        this.clearLocalStorageCart();
                    } else {
                        console.error('Failed to sync cart with server');
                    }
                } catch (error) {
                    console.error('Error syncing cart with server:', error);
                }
            }
        },
        clearLocalStorageCart() {
            localStorage.removeItem('cart');
            console.log('Local storage cart cleared');
        },
    },
});
</script>