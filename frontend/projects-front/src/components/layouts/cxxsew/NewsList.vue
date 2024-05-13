<template>
  <div class="works" v-if="news.length">
    <div class="work" v-for="ns in news" :key="ns.id">
        <a :href="`/cxxsew/news/${ns.id}`">
            <img :src="imageUrl(ns.image.url)" alt="">
            <div class="list-title-wrap news-list">
                <p class="center">title: {{ ns.title }}</p>
            </div>
        </a>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { News } from '@/types/news';

export default defineComponent({
  name: 'NewsList',
  data() {
    return {
      news: [] as News[],
    };
  },
  created() {
  },
  mounted() {
    this.fetchNews();
  },
  methods: {
    async fetchNews() {
      try {
        const response = await this.$api.get<News[]>('/news');
        this.news = response.data;
        console.log(this.news);
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
