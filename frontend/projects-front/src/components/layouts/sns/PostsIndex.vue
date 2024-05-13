<template>
    <div class="contents sns-top" id="sns-contents">
        <div class="works sns-posts" id="posts-each-do">
            <PostsList :posts="posts" />
        </div>
        <div v-if="spinnerVisible" id="loading">
            <div class="spinner"></div>
        </div>
    </div>
 </template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { Post } from '@/types/post';
import PostsList from './PostsList.vue';

export default defineComponent({
    name: 'PostsShow',
    data() {
        return {
            posts: [] as Post[],
            spinnerVisible: false,
            isFetching: false,
            noMorePosts: false,
            page: 1,
            timer: null as number | null,
        };
    },
    components: {
        PostsList,
    },
    mounted() {
        window.addEventListener('scroll', this.handleScroll);
        this.fetchPosts();
    },
    beforeUnmount() {
        window.removeEventListener('scroll', this.handleScroll);
    },
    methods: {
        setSpinnerVisibility(visible: boolean) {
            this.spinnerVisible = visible;
        },
        delay(duration: number) {
            return new Promise(resolve => setTimeout(resolve, duration));
        },
        async handleScroll() {
            // スクロールのたびにフラグをチェック
            if (this.isFetching || this.noMorePosts) return;
            // 既存のタイマーがあればクリア
            clearTimeout(this.timer as number);
            
            this.setSpinnerVisibility(true);

            await this.delay(1000);

            let nearBottom = window.innerHeight + window.scrollY >= document.body.offsetHeight - 500;
            if (nearBottom) {
                this.fetchPosts();
            }
            this.setSpinnerVisibility(false);
        },
        async fetchPosts() {
            if (this.isFetching) return;
            this.isFetching = true;

            try {
                const response = await this.$api.get<Post[]>(`/posts?page=${this.page}`, {
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                if (response.data.length === 0) {
                    this.noMorePosts = true;
                    return;
                }
                this.posts = [...this.posts, ...response.data];
                this.page++;
            } catch (error) {
                console.error(error);
            } finally {
                this.isFetching = false;
            }
        },
    },
});
</script>