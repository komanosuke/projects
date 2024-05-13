<template>
    <div id="loading-wrapper">
        <div v-for="post in posts" :key="post.id" class="work sns-post">
            <div class="posted-post-id">{{ post.id }}</div>
            <div class="thumb-wrapper">
                <a v-if="$isLoggedIn()" :href="`/posts/user_home/${post.user_id}`" class="sns-users-link">
                    <div class="post-name-wrapper">
                        <img v-if="post.user_image_url" :src="$baseURL + post.user_image_url" class="sns-thumb" alt="" />
                        <p class="posts-user-name">{{ post.user_name }}</p>
                        <p>{{ post.user_username }}</p>
                    </div>
                </a>
                <a v-else href="/login" class="sns-users-link">
                    <div class="post-name-wrapper">
                        <img v-if="post.user_image_url" :src="$baseURL + post.user_image_url" class="sns-thumb" alt="" />
                        <p class="posts-user-name">{{ post.user_name }}</p>
                        <p>{{ post.user_username }}</p>
                    </div>
                </a>
            </div>
            <a :href="`/posts/${post.id}`">
                <p class="post-content">{{ post.content }}</p>
                <img v-if="post.image_url && post.image_url" :src="$baseURL + post.image_url" class="sns-post-img" alt="" />
            </a>
            <div v-if="$isLoggedIn()" class="like-com-wrapper">
                <PostsLikes :isNotCurrentUserPost="post.user_id != currentUser.id" :post-id="post.id" :initial-liked="post.initial_liked" :initial-likes-count="post.initial_likes_count" />
                <div class="sns-like-com">
                    <img src="@/assets/images/comment.jpeg" class="icon" alt="" />
                </div>
                <div>{{ post.initial_comments_count }}</div>
            </div>
            <div v-else class="like-com-wrapper">
                <div class="sns-like-com">
                    <img src="@/assets/images/like_white.svg" class="like-btn" id="cant-push" alt="">
                </div>
                <div>{{ post.initial_likes_count }}</div>
                <div class="sns-like-com">
                    <img src="@/assets/images/comment.jpeg" class="icon" alt="" />
                </div>
                <div>{{ post.initial_comments_count }}</div>
            </div>
        </div>
    </div>
 </template>
 

<script lang="ts">
import { defineComponent, PropType } from 'vue';
import type { CurrentUser } from '@/types/user';
import type { Post } from '@/types/post';
import PostsLikes from './PostsLikes.vue';

export default defineComponent({
    name: 'PostsList',
    props: {
        posts: Array as PropType<Post[]>,
    },
    components: {
        PostsLikes,
    },
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