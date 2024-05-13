<template>
    <ul class="sns-ul">
        <a href="/posts/index"><li>ホーム</li></a>
        <a href="/posts/new"><li>投稿作成</li></a>
        <div v-if="$isLoggedIn()">
            <a :href="`/posts/user_home/${currentUser.id}`"><li>マイページ</li></a>
            <a :href="`/posts/followers/${currentUser.id}`"><li>フォロワー 一覧</li></a>
            <a :href="`/posts/followed/${currentUser.id}`"><li>フォロー中 一覧</li></a>
        </div>
    </ul>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { CurrentUser } from '@/types/user';

export default defineComponent({
    name: 'SideBar',
    data() {
        return {
            currentUser: {} as CurrentUser,
        };
    },
    mounted() {
        if (this.$isLoggedIn()) {
            this.fetchCurrentUser();
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