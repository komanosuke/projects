<template>
    <div>
        <h1>アカウントを有効化</h1>
        <button @click="activateAccount">アカウントを有効化する</button>
        <p v-if="message">{{ message }}</p>
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
        };
    },
    methods: {
        async activateAccount() {
            const email = this.$route.query.email;

            console.log('Token:', this.token);
            console.log('Email:', email);
            
            try {
                const response = await this.$api.get(`/account_activations/${this.token}/edit`, {
                    params: { email }
                });
                console.log('Account activated successfully:', response);
                this.message = 'アカウントが有効化されました。';
            } catch (error) {
                console.error('Error creating user:', error);
                this.message = 'アカウント作成に失敗しました。';
            }
        }
    },
});
</script>