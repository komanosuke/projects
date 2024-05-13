<template>
    <div class="contents" id="sns-contents">
        <h2>フォロワー 一覧</h2>
        <PostsFollowUsersList :users="followerUsers"/>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { User } from '@/types/user';
import PostsFollowUsersList from './PostsFollowUsersList.vue';

export default defineComponent({
    name: 'PostsFollowers',
    components: {
        PostsFollowUsersList,
    },
    props: {
        id: String,
    },
    data() {
        return {
            followerUsers: [] as User[],
        };
    },
    mounted() {
        this.fetchfollowerUsers();
    },
    methods: {
        async fetchfollowerUsers() {
            try {
                const response = await this.$api.get<User[]>(`/users/${this.id}/followers`,{
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                this.followerUsers = response.data;
                console.log(response.data);
            } catch (error) {
                console.error('フォロワーユーザーの取得に失敗しました。', error);
            }
        },
    },
});
</script>