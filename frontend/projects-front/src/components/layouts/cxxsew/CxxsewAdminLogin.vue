<template>
    <div v-if="$isAdminLoggedIn()" id="cxxsew-contents">
        <div class="article">
            <h1>- ADMINにログイン中 -</h1>
            <a href="/cxxsew/admin" class="btn">ADMIN管理画面トップへ</a>
        </div>
    </div>
    <div v-else id="cxxsew-contents">
        <div class="article">
            <h1>- 管理者専用ログイン画面 -</h1>
            <form @submit.prevent="login">
                <input v-model="credentials.name" type="text" id="name" name="name" placeholder="管理者IDを入力してください" />
                <label for="password">パスワード</label>
                <input v-model="credentials.password" type="password" id="password" name="password" placeholder="パスワードを入力してください" />
                <button type="submit" class="btn" id="submit-btn">Log in</button>
            </form>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { AxiosError } from 'axios';

export default defineComponent({
    name: 'CxxsewAdminLogin',
    data() {
        return {
            credentials: {
                name: '',
                password: '',
            },
        };
    },
    mounted() {
    },
    methods: {
        async login() {
            try {
                const response = await this.$api.post('/admin_login', this.credentials);
                this.handleLoginSuccess(response.data.jwt);
            } catch (error) {
                this.handleLoginError(error);
            }
        },
        handleLoginSuccess(token: string) {
            if (!token) throw new Error("Token not provided in the response");
            localStorage.setItem('adminToken', token);
            this.$api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
            this.$router.push('/');
            console.log(token);
        },
        handleLoginError(error: unknown) {
            if (error instanceof AxiosError) {
                console.error('Request failed with status code:', error.response?.status);
            } else {
                console.error('An unknown error occurred:', error);
            }
        },
    },
});
</script>