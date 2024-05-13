<template>
    <div id="cxxsew-contents">
        <p id="content-date">{{ news.update_at }}</p>
        <h1 id="blog-title" class="center">{{ news.title }}（Vol.{{ news.id }}）</h1>
        
        <div class="work-box" id="content-box">
            <img v-if="news.image" :src="imageUrl(news.image.url)" class="content-img" :alt="news.title"/>
            <div class="content-img-title">- {{ news.image_title }} -</div>
            <p>{{ news.text }}</p>
        </div>
    
        <div class="btn" id="submit-btn">
            <a href="/cxxsew/news">News一覧に戻る</a>
        </div>
    </div>
</template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  import type { News } from '@/types/news';
  
  export default defineComponent({
      name: 'NewsShow',
      data() {
          return {
              news: {} as News,
          };
      },
      props: {
          id: String,
      },
      mounted() {
          this.fetchNews();
      },
      computed: {
      },
      methods: {
          async fetchNews() {
              try {
                  const response = await this.$api.get<News>(`/news/${this.id}`);
                  this.news = response.data;
              } catch (error) {
                  console.error(error);
              }
          },
          imageUrl(url: string): string {
              return this.$baseURL + url;
          },
      }
  });
  </script>