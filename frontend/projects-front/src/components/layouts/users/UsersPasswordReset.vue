<template>
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
                <button type="submit" class="btn submit-btn">更新する</button>
            </div>
        </form>
        <p v-if="message">{{ message }}</p>
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
        };
    },
    methods: {
        async passwordReset() {
            const email = this.$route.query.email;

            console.log('Token:', this.token);
            console.log('Email:', email);
            
            try {
                const response = await this.$api.patch(`/password_resets/${this.token}`, {
                    email: email,
                    user: {
                        password: this.password,
                        password_confirmation: this.passwordConfirmation,
                    },
                });
                console.log('Password reset successfully:', response);
                this.message = 'パスワードが正常にリセットされました。';
            } catch (error) {
                console.error('Error resetting password');
                this.message = 'パスワードリセットに失敗しました。';
            }
        },
    },
});
</script>