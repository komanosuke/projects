<template>
    <form @submit.prevent="toggleFollow">
        <button type="submit" class="follow-btn">{{ isFollowing ? 'フォロー解除' : 'フォロー' }}</button>
    </form>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'PostsRelationships',
    data() {
        return {
            isFollowing: this.initialIsFollowing,
        };
    },
    props: {
        postUserId: Number,
        initialIsFollowing: Boolean,
    },
    methods: {
        async toggleFollow() {
            const userId = this.postUserId;
            const url = `/users/${userId}/relationships`;
            const method = this.isFollowing ? 'delete' : 'post';
            try {
                const response = await this.$api({
                    method: method,
                    url: url,
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    },
                    data: this.isFollowing ? {} : { followed_id: userId }
                });
                this.isFollowing = response.data.is_following;
            } catch (error) {
                console.error('Error toggling follow:', error);
            }
        },
    },
});
</script>