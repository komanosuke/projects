<template>
    <div id="overlay" v-if="overlay">
        <div class="loader"></div>
    </div>
    <div>
        <h1>アカウントを有効化</h1>
        <button @click="activateAccount" class="btn pf-submit" v-if="beforeSuccess">有効化する</button>
        <p v-if="message" class="center">{{ message }}</p>
        <a href="/login" class="btn pf-submit" v-if="!beforeSuccess">ログイン画面へ</a>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'UsersActivateAccount',
    props: {
        token: String,
    },
    data() {
        return {
            message: '',
            overlay: false,
            beforeSuccess: true,
        };
    },
    methods: {
        async activateAccount() {
            this.overlay = true;
            const email = this.$route.query.email;
            
            try {
                const response = await this.$api.get(`/account_activations/${this.token}/edit`, {
                    params: { email }
                });
                console.log('Account activated successfully:', response);
                this.message = 'アカウントが有効化されました。';
                this.beforeSuccess = false;
            } catch (error) {
                console.error('Error creating user:', error);
                this.message = 'アカウント作成に失敗しました。';
            } finally {
                this.overlay = false;
            }
        }
    },
});
</script>