<template>
    <main>
        <div class="contents" id="login-con">
            <h1>- アカウント登録 -</h1>
            <form @submit.prevent="createUser">
                <div class="form-group">
                    <label for="name">アカウント名（必須）</label>
                    <input v-model="user.name" type="text" required>
                </div>
                <div class="form-group">
                    <label for="name">アカウントID（必須）※登録後、先頭に@がつきます</label>
                    <input v-model="user.username" type="text" required>
                </div>
                <div class="form-group">
                    <label for="email">メールアドレス（必須）</label>
                    <input v-model="user.email" type="email" required>
                </div>
                <div class="form-group">
                    <label for="password">パスワード（必須）※8文字以上20文字以下</label>
                    <input v-model="user.password" type="password" required minlength="8" maxlength="20">
                </div>
                <div class="form-group">
                    <label for="zip">郵便番号（必須）</label>
                    <input v-model="user.zip" type="text" required>
                </div>
                <div class="form-group">
                    <label for="prefecture">住所(都道府県)（必須）</label>
                    <input v-model="user.prefecture" type="text" required>
                </div>
                <div class="form-group">
                    <label for="city">住所(市区町村)（必須）</label>
                    <input v-model="user.city" type="text" required>
                </div>
                <div class="form-group">
                    <label for="street">それ以降の住所（必須）</label>
                    <input v-model="user.street" type="text" required>
                </div>
                <div class="form-group">
                    <label for="tel">電話番号（必須）</label>
                    <input v-model="user.tel" type="text" required>
                </div>
                <div class="form-group">
                    <label for="profile">プロフィール内容（必須）</label>
                    <input v-model="user.profile" type="text" required>
                </div>
                <button type="submit" class="pf-submit">作成</button>
            </form>
        </div>
    </main>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { NewUser } from '@/types/user';

export default defineComponent({
    name: 'UsersNew',
    data() {
        return {
            user: {
                name: '',
                username: '',
                email: '',
                password: '',
                zip: '',
                prefecture: '',
                city: '',
                street: '',
                tel: '',
                profile: ''
            } as NewUser,
            message: '',
            users: [],
        };
    },
    methods: {
        async createUser() {
            try {
                const response = await this.$api.post('/users', {
                    user: this.user
                });
                console.log('Post created successfully:', response);
                this.message = response.data.message;
                // this.$router.push('/users');
            } catch (error) {
                console.error('Error creating user:', error);
                this.message = 'アカウント作成に失敗しました。';
            }
        },
    },
});
</script>