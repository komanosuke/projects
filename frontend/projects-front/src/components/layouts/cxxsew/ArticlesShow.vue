<template>
    <div id="cxxsew-contents">
        <div v-if="!errorMessage">
            <p id="content-date">{{ article.update_at }}</p>
            <h1 id="blog-title" class="center">{{ article.title }}（Vol.{{ article.id }}）</h1>
            
            <div class="work-box" id="content-box">
                <img v-if="article.image" :src="imageUrl(article.image.url)" class="content-img" :alt="article.title"/>
                <div class="content-img-title">- {{ article.image_title }} -</div>
                <p>{{ article.text }}</p>
            </div>
        </div>
        <div v-else>
            <h1 id="blog-title" class="center">{{ errorMessage }}</h1>
        </div>
    
        <div class="btn" id="submit-btn">
            <a href="/cxxsew/articles">Articles一覧に戻る</a>
        </div>
    </div>
</template>
  
<script lang="ts">
import { defineComponent } from 'vue';
import type { Article } from '@/types/article';

export default defineComponent({
    name: 'ArticlesShow',
    data() {
        return {
            article: {} as Article,
            errorMessage: '',
        };
    },
    props: {
        id: String,
    },
    mounted() {
        this.fetchArticle();
    },
    methods: {
        async fetchArticle() {
            try {
                const response = await this.$api.get<Article>(`/articles/${this.id}`);
                this.article = response.data;
            } catch (error) {
                this.errorMessage = '記事が存在しません。';
                console.error(error);
            }
        },
        imageUrl(url: string): string {
            return this.$baseURL + url;
        },
    }
});
  </script>