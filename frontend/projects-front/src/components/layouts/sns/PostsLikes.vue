<template>
    <div class="sns-like-com" v-if="isNotCurrentUserPost">
        <img v-if="liked" @click.prevent="toggleLike" src="@/assets/images/like_black.svg" class="like-btn" alt="">
        <img v-else @click.prevent="toggleLike" src="@/assets/images/like_white.svg" class="like-btn" alt="">
    </div>
    <div class="sns-like-com" v-else>
        <img src="@/assets/images/like_white.svg" class="like-btn" id="cant-push" alt="">
    </div>
    <div>{{ likesCount }}</div>       
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'PostsLikes',
    props: {
        postId: Number,
        initialLiked: Boolean,
        initialLikesCount: Number,
        isNotCurrentUserPost: Boolean,
    },
    data() {
        return {
            liked: this.initialLiked,
            likesCount: this.initialLikesCount || 0
        };
    },
    methods: {
        async toggleLike() {
            const url = `/posts/${this.postId}/likes`;
            const method = this.liked ? 'delete' : 'post';
            try {
                const response = await this.$api({
                    method: method,
                    url: url,
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                console.log(response.data);
                this.liked = !this.liked;
                this.likesCount = this.liked ? this.likesCount + 1 : this.likesCount - 1;
            } catch (error) {
                console.error('Error toggling like:', error);
            }
        },
    },
});
</script>