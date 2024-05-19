<template>
    <div id="overlay" v-if="overlay">
        <div class="loader"></div>
    </div>
    <div class="contents" id="login-con">
        <h1>パスワード再設定フォーム</h1>
        <form @submit.prevent="passwordReset">
            <div class="txt_field">
                <label for="password">新しいパスワード</label>
                <input
                    v-model="password"
                    type="password"
                    placeholder="新しいパスワードを入力してください"
                    required
                >
                <label for="password">新しいパスワード（確認用）</label>
                <input
                    v-model="passwordConfirmation"
                    type="password"
                    placeholder="新しいパスワードを入力してください"
                    required
                >
                <p v-if="!matchPassword" class="center">確認用パスワードが一致していません。</p>
                <button type="submit" class="btn submit-btn" v-if="beforeSuccess">更新する</button>
                <a href="/login" class="btn pf-submit" v-if="!beforeSuccess">ログイン画面へ</a>
            </div>
        </form>
        <p v-if="message" class="center">{{ message }}</p>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'UsersPasswordReset',
    props: {
        token: String,
    },
    data() {
        return {
            message: '',
            password: '',
            passwordConfirmation: '',
            overlay: false,
            beforeSuccess: true,
        };
    },
    computed: {
        matchPassword(): boolean {
            if (this.password === this.passwordConfirmation) {
                return true;
            } else {
                return false;
            }
        },
    },
    methods: {
        async passwordReset() {
            this.overlay = true;
            const email = this.$route.query.email;
            
            try {
                const response = await this.$api.patch(`/password_resets/${this.token}`, {
                    email: email,
                    user: {
                        password: this.password,
                        password_confirmation: this.passwordConfirmation,
                    },
                });
                console.log('Password reset successfully:', response);
                this.message = 'パスワードが正常にリセットされました。新しいパスワードをお使いください。';
                this.beforeSuccess = false;
            } catch (error) {
                console.error('Error resetting password');
                this.message = 'パスワードリセットに失敗しました。';
            } finally {
                this.overlay = false;
            }
        },
    },
});
</script>