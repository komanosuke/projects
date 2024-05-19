<template>
    <div v-if="!isLoading">
        <h1>- Account Information -</h1>
        <div id="profile-user">
            <h2>基本情報</h2>
            <div id="profile-user-wrapper">
                <table id="profile-table">
                    <tr>
                        <th>名前</th>
                        <td>{{ currentUser.name }}</td>
                    </tr>
                    <tr>
                        <th>ID</th>
                        <td>{{ currentUser.username }}</td>
                    </tr>
                    <tr>
                        <th>紹介文</th>
                        <td>
                            <span v-if="currentUser.profile">{{ currentUser.profile }}</span>
                            <span v-else>紹介文が登録されていません。</span>
                        </td>
                    </tr>
                </table>
                <img v-if="currentUser.image" :src="$baseURL + currentUser.image.url" class="profile-thumb" alt="">
            </div>
        </div>
        <div id="profile-cxxsew">
            <h2>カート内容</h2>
            <div class="btn sub-btn">
                <a href="/cxxsew/purchase">カート内容を確認</a>
            </div>
        </div>
        <!-- <div id="profile-study">
            <h2>学習記録</h2>
            <div class="btn sub-btn">
                <a href="/education/collection">学習記録を見る</a>
            </div>
        </div> -->
        <div id="profile-sns">
            <h2>投稿内容</h2>
            <div class="btn sub-btn">
                <a :href="`/posts/user_home/${currentUser.id}`">SNS投稿内容を確認</a>
            </div>
        </div>
    </div>
    <div v-else>
        <h1>{{ message }}</h1>
        <img src="@/assets/images/wolf.png" class="profile-thumb" id="no-follow-thumb" alt="">
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { CurrentUser } from '@/types/user';

export default defineComponent({
    name: 'UsersShow',
    props: {
        id: String,
    },
    data() {
        return {
            currentUser: {} as CurrentUser,
            message: '',
            isLoading: true,
        };
    },
    async mounted() {
        await this.fetchCurrentUser();
        if (this.currentUser.id !== Number(this.id)) {
            this.message = 'ログインユーザーのページではありません。';
        } else {
            this.isLoading = false;
        }
    },
    methods: {
        async fetchCurrentUser() {
            try {
                const response = await this.$api.get<CurrentUser>('/users/current',{
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                this.currentUser = response.data;
            } catch (error) {
                console.error(error);
            }
        },
    },
});
</script>