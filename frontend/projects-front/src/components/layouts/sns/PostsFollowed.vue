<template>
    <div class="contents" id="sns-contents">
        <h2>フォロー中 一覧</h2>
        <PostsFollowUsersList :users="followedUsers"/>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { User } from '@/types/user';
import PostsFollowUsersList from './PostsFollowUsersList.vue';

export default defineComponent({
    name: 'PostsFollowed',
    components: {
        PostsFollowUsersList,
    },
    props: {
        id: String,
    },
    data() {
        return {
            followedUsers: [] as User[],
        };
    },
    mounted() {
        this.fetchfollowedUsers();
    },
    methods: {
        async fetchfollowedUsers() {
            try {
                const response = await this.$api.get<User[]>(`/users/${this.id}/follows`,{
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                this.followedUsers = response.data;
                console.log(response.data);
            } catch (error) {
                console.error('フォロー中のユーザーの取得に失敗しました。', error);
            }
        },
    },
});
</script>
