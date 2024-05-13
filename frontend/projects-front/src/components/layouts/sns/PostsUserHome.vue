<template>
    <div class="contents" id="sns-contents">
        <div id="sns-container" v-if="isValidUser">
            <h1>基本情報</h1>
            <div id="posted-user-id">{{ user.id }}</div>
            <div id="profile-user-wrapper">
                <img v-if="user.image_url"  :src="$baseURL + user.image_url" class="profile-thumb" alt="">
                <table id="profile-table">
                    <tr>
                        <th>名前</th>
                        <td>{{ user.name }}</td>
                    </tr>
                    <tr>
                        <th>ID</th>
                        <td>{{ user.username }}</td>
                    </tr>
                    <tr>
                        <th>紹介文</th>
                        <td>
                            <span v-if="user.profile !== ''">{{ user.profile }}</span>
                            <span v-else>紹介文が登録されていません。</span>
                        </td>
                    </tr>
                </table>
            </div>
            <div v-if="user.id !== currentUser.id" class="follow-wrapper" id="show-follow-wrapper">
                <PostsRelationships :post-user-id="user.id" :initial-is-following="user.is_following"/>
            </div>
            <div id="change-post-wrapper">
                <div id="change-post">
                    <button v-for="category in categories" :key="category.value"
                        class="btn submit-btn sns-tab-btn"
                        :style="{ background: selectedCategory === category.value ? 'rgb(92, 182, 182)' : 'darkcyan' }"
                        @click="changePostCategory(category.value)">
                        {{ category.text }}
                    </button>
                </div>
                <div v-if="posts.length > 0">
                    <PostsList :posts="posts" />
                </div>
                <p v-else id="not-yet-post">まだ投稿はありません。</p>
                <div v-if="spinnerVisible" id="loading">
                    <div class="spinner"></div>
                </div>
            </div>
        </div>
        <div id="sns-container" v-else>
            {{ alert }}
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { Post } from '@/types/post';
import type { User, CurrentUser } from '@/types/user';
import PostsRelationships from './PostsRelationships.vue';
import PostsList from './PostsList.vue';

export default defineComponent({
    name: 'PostsUserHome',
    components: {
        PostsRelationships,
        PostsList,
    },
    props: {
        id: String,
    },
    data() {
        return {
            selectedCategory: 'posted',
            categories: [
                { value: 'posted', text: 'My Post' },
                { value: 'liked', text: 'Liked' },
                { value: 'commented', text: 'Commented' }
            ],
            posts: [] as Post[],
            user: {} as User,
            currentUser: {} as CurrentUser,
            isValidUser: false,
            noMorePosts: false,
            alert: '',
            spinnerVisible: false,
            isFetching: false,
            page: 1,
            timer: null as number | null,
        };
    },
    mounted() {
        window.addEventListener('scroll', this.handleScroll);
        this.fetchUser();
        this.fetchCurrentUser();
        this.fetchPosts();
    },
    beforeUnmount() {
        window.removeEventListener('scroll', this.handleScroll);
    },
    methods: {
        changePostCategory(newCategory: string) {
            window.removeEventListener('scroll', this.handleScroll);
            this.selectedCategory = newCategory;
            this.noMorePosts = false;
            this.posts = [];
            this.page = 1;
            this.fetchPosts();
            window.addEventListener('scroll', this.handleScroll);
        },
        async fetchUser() {
            try {
                const response = await this.$api.get<User>(`/users/${this.id}`,{
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                console.log(response.data);
                this.user = response.data;
                this.isValidUser = true;
            } catch (error) {
                this.alert = '指定のユーザーは存在しません。';
                console.error(error);
            }
        },
        async fetchCurrentUser() {
            try {
                const response = await this.$api.get<CurrentUser>('/users/current',{
                    headers: {
                        Authorization: `Bearer ${this.$getAuthToken()}`
                    }
                });
                console.log(response.data);
                this.currentUser = response.data;
            } catch (error) {
                console.error(error);
            }
        },
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
                const response = await this.$api.get<Post[]>(`/users/${this.id}/posts/${this.selectedCategory}/?page=${this.page}`, {
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