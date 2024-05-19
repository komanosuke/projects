<template>
<LoginHeader/>
    <main>
        <div class="contents">
            <h1>- Services -</h1>
            <p id="home-p">
                ご訪問いただきありがとうございます。以下はご利用可能なサービスの一覧です。
            </p>
            <p v-if="$isLoggedIn()" style="color: indianred;"><strong>ログイン中です。データの保存が可能です。</strong></p>
            <p v-else>ユーザー登録してログインすると、データ保存ができます。</p>
            <div class="works pfs">
                <div class="work pf" v-for="work in works" :key="work.id">
                    <a :href="work.link">
                        <img :src="work.image" :alt="work.alt" />
                        <div class="pf-p-wrapper">
                        <p>{{ work.description }}</p>
                        </div>
                    </a>
                </div>
            </div>
            <a v-if="$isLoggedIn()" :href="`/users/${currentUser.id}`">
                <div class="btn sub-btn" id="my-profile">My Page</div>
            </a>
        </div>
    </main>
<LoginFooter/>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import LoginHeader from './../components/layouts/login/LoginHeader.vue';
import LoginFooter from './../components/layouts/login/LoginFooter.vue';
import type { CurrentUser } from '@/types/user';

export default defineComponent({
    name: 'HomeIndex',
    components: {
        LoginHeader,
        LoginFooter,
    },
    data() {
        return {
            works: [
                {
                    id: 1,
                    link: '/cxxsew/index',
                    image: `${this.$baseURL}/images/lion.jpeg`,
                    alt: '',
                    description: 'デザイナーズTシャツのECサイト',
                },
                {
                    id: 2,
                    link: '/posts/index',
                    image: `${this.$baseURL}/images/art.png`,
                    alt: '',
                    description: 'デザイナーズSNS',
                },
                {
                    id: 3,
                    link: '/mobile',
                    image: `${this.$baseURL}/images/gadget.png`,
                    alt: '',
                    description: 'スマホIoT連携アプリ',
                },
                {
                    id: 4,
                    link: '/money',
                    image: `${this.$baseURL}/images/money.png`,
                    alt: '',
                    description: '生涯収支の概算アプリ',
                },
                {
                    id: 5,
                    link: 'https://liberal-earth.com/pension/',
                    image: `${this.$baseURL}/images/tree.jpeg`,
                    alt: '',
                    description: '年金試算アプリ',
                },
                {
                    id: 6,
                    link: '/media',
                    image: `${this.$baseURL}/images/ai_space.png`,
                    alt: '',
                    description: 'AI関連ニュースメディアサイト',
                },
            ],
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