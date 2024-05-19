<template>
    <div id="overlay" v-if="overlay">
        <div class="loader"></div>
    </div>
    <div class="contents" id="login-con">
       <h1>パスワード再設定</h1>
       <p>入力されたメールアドレス宛にパスワード再設定メールを送信しますので、メールの指示に従ってパスワードの再設定手続きをして下さい。</p>
       <form @submit.prevent="passwordReset">
           <label for="email">メールアドレス</label>
           <input
               v-model="email"
               type="email"
               placeholder="メールアドレスを入力してください"
               required
           >
           <button type="submit" class="btn submit-btn">送信する</button>
       </form>
       <p class="center">{{ message }}</p>
   </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'UsersPasswordResetNew',
    data() {
        return {
            email: '',
            message: '',
            overlay: false,
        };
    },
    methods: {
        async passwordReset() {
            this.overlay = true;
            
            try {
                const response = await this.$api.post('/password_resets', {
                    email: this.email
                });
                console.log('Password Reset Mail sent successfully:', response);
                this.message = 'パスワードリセットのメールを送信しました。メールでの手続きを進めてください。';
            } catch (error) {
                console.error('Error send Password Reset Mail:', error);
                this.message = 'メール送信に失敗しました。';
            } finally {
                this.overlay = false;
            }
        }
    },
});
</script>