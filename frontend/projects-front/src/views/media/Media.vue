<template>
    <LoginHeader/>
    <main id="media-main">
        <div id="media-back-cover"></div>
        <div class="contents" id="media-con">
            <h1>AIに関する新着ニュース</h1>
            <div class="article">
                <p class="center color-white">YahooニュースからAIに関する新着ニュースをスクレイピングしています。</p>
            </div>
            <div class="works pfs">
                <div v-for="article in articles" :key="article.url" class="work pf">
                    <a :href="article.url" target="_blank">
                        <img :src="article.image" alt="">
                        <div class="pf-p-wrapper media-wrapper">
                            <p>{{ article.title }}</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </main>
    <LoginFooter/>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import LoginHeader from '../../components/layouts/login/LoginHeader.vue';
import LoginFooter from '../../components/layouts/login/LoginFooter.vue';
import '@/assets/stylesheets/media/media.css';

interface Article {
    url: string;
    image: string;
    title: string;
}

export default defineComponent({
    name: 'AppMedia',
    components: {
        LoginHeader,
        LoginFooter,
    },
    data() {
        return {
            articles: [] as Article[],
            currentPage: 1,
            totalPages: 0
        };
    },
    methods: {
        async fetchArticles(page = 1) {
            try {
                const response = await this.$api.get(`/media?page=${page}`);
                this.articles = response.data.articles;
                this.totalPages = response.data.total_pages;
                this.currentPage = page;
            } catch (error) {
                console.error('Failed to fetch articles:', error);
            }
        },
        changePage(page: number) {
            this.fetchArticles(page);
        }
    },
    mounted() {
        this.fetchArticles();
    },
});
</script>