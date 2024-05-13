<template>
  <div class="works" v-if="articles.length">
    <div class="work" v-for="article in articles" :key="article.id">
        <a :href="`/cxxsew/articles/${article.id}`">
            <img :src="imageUrl(article.image.url)" alt="">
            <div class="list-title-wrap news-list">
                <p class="center">title: {{ article.title }}</p>
            </div>
        </a>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { Article } from '@/types/article';

export default defineComponent({
  name: 'ArticlesList',
  data() {
    return {
      articles: [] as Article[],
    };
  },
  created() {
  },
  mounted() {
    this.fetchArticles();
  },
  methods: {
    async fetchArticles() {
      try {
        const response = await this.$api.get<Article[]>('/articles');
        this.articles = response.data;
        console.log(this.articles);
      } catch (error) {
        console.error(error);
      }
    },
    imageUrl(url: string): string {
      return this.$baseURL + url;
    },
  },
});
</script>

<style scoped>

</style>
