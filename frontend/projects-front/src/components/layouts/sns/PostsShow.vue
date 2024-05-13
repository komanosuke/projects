<template>
    <div class="contents" id="sns-contents">
        <div id="sns-container" v-if="isValidPost">
            <div class="posts-show-container">
                <a v-if="post" :href="`/posts/user_home/${post.user_id}`" class="post-name" id="sns-show-post-name">
                    <img :src="$baseURL + post.user_image_url" class="sns-thumb" alt="">
                    <p>{{ post.user_name }}</p>
                    <p>{{ post.user_username }}</p>
                </a>
                <div class="follow-wrapper" id="show-follow-wrapper">
                    <div v-if="post && (post.user_id !== currentUser.id)">
                        <PostsRelationships :post-user-id="post.user_id" :initial-is-following="post.is_following"/>
                    </div>
                </div>
            </div>
            <p class="left">{{ post.content }}</p>
            <img v-if="post.image_url" :src="$baseURL + post.image_url" class="sns-post-img sns-show-img" alt="">
            <div class="like-com-wrapper">
                <PostsLikes :isNotCurrentUserPost="post.user_id != currentUser.id" :postId="post.id" :initialLiked="post.initial_liked" :initialLikesCount="post.initial_likes_count" />
                <div class="sns-like-com">
                    <img src="@/assets/images/comment.jpeg" class="icon" alt="" />
                </div>
                <div>{{ post.initial_comments_count }}</div>
            </div>
            <p>コメントしてみる</p>
            <form @submit.prevent="createComment">
                <textarea v-model="commentContent" maxlength="200" placeholder="コメントを入力してください" required></textarea>
                <button type="submit" class="sns-btn">コメント投稿する</button>
            </form>
            <p>コメント投稿 一覧<span> / コメント数: {{ comments.length }}</span></p>
            <div v-if="comments">
                <div v-for="comment in comments" :key="comment.id" class="thumb-wrapper comment-wrapper">
                    <a :href="`/posts/user_home/${comment.user_id}`" class="sns-users-link-comment">
                        <div class="post-name-wrapper">
                            <img :src="$baseURL + comment.user_image_url" class="sns-thumb" alt="">
                            <p>{{ comment.user_name }}</p>
                            <p>{{ comment.user_username }}</p>
                        </div>
                    </a>
                    <p class="left link-comment-content">{{ comment.content }}</p>
                </div>
            </div>
            <p v-else>コメントはありません。</p>
        </div>
        <div id="sns-container" v-else>
            {{ alert }}
        </div>
        <div v-if="spinnerVisible" id="loading">
            <div class="spinner"></div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { Post } from '@/types/post';
import type { User, CurrentUser } from '@/types/user';
import type { Comment } from '@/types/comment';
import PostsRelationships from './PostsRelationships.vue';
import PostsLikes from './PostsLikes.vue';

export default defineComponent({
    name: 'PostsShow',
    data() {
        return {
            post: {} as Post,
            comments: [] as Comment[],
            commentContent: '',
            page: 1,
            spinnerVisible: false,
            isFetching: false,
            timer: null as number | null,
            currentUser: {} as CurrentUser,
            postUser: {} as User,
            noMoreComments: false,
            isValidPost: false,
            alert: '',
        };
    },
    components: {
        PostsRelationships,
        PostsLikes,
    },
    props: {
        id: String,
    },
    mounted() {
        window.addEventListener('scroll', this.handleScroll);
        this.fetchPost();
        this.fetchComments();
        this.fetchCurrentUser();
    },
    methods: {
        delay(duration: number) {
            return new Promise(resolve => setTimeout(resolve, duration));
        },
        async handleScroll() {
            // スクロールのたびにフラグをチェック
            if (this.isFetching || this.noMoreComments) return;
            // 既存のタイマーがあればクリア
            clearTimeout(this.timer as number);

            this.spinnerVisible = true;

            await this.delay(1000);

            let nearBottom = window.innerHeight + window.scrollY >= document.body.offsetHeight - 500;
            if (nearBottom) {
                this.fetchComments();
            }
            this.spinnerVisible = false;
        },
        async fetchPost() {
            try {
                const response = await this.$api.get<Post>(`/posts/${this.id}`, {
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    },
                });
                this.post = response.data;
                this.isValidPost = true;
            } catch (error) {
                this.alert = '指定の投稿は存在しません。';
                console.error(error);
            }
        },
        async fetchComments() {
            if (this.isFetching || this.noMoreComments) return;
            this.isFetching = true;

            try {
                const response = await this.$api.get<Comment[]>(`/posts/${this.id}/comments?page=${this.page}`, {
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    },
                });
                if (response.data.length === 0) {
                    this.noMoreComments = true;
                    return;
                }
                this.comments = [...this.comments, ...response.data];
                this.page++;
            } catch (error) {
                console.error(error);
            } finally {
                this.isFetching = false;
            }
        },
        async createComment() {
            try {
                const response = await this.$api.post(`posts/${this.id}/comments`,
                    {
                        content: this.commentContent
                    },
                    {
                        headers: {
                            'Authorization': `Bearer ${this.$getAuthToken()}`,
                        },
                    }
                );
                this.comments = [response.data, ...this.comments];
                console.log(this.comments);
                console.log('Comment created successfully:', response);
            } catch (error) {
                console.error('Error creating post:', error);
            }
        },
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