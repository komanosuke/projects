<template>
  <div class="works" v-if="works.length">
    <div class="work" v-for="work in works" :key="work.id">
        <a :href="`/cxxsew/works/${work.id}`">
            <img :src="imageUrl(work.image.url)" alt="">
            <div class="list-title-wrap">
                <p>title: {{ work.title }} 
                <span v-if="work.onlyone">◆</span>
                <br>price: ¥{{ work.price.toLocaleString() }}</p>
            </div>
        </a>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import type { Work } from '@/types/work';

export default defineComponent({
  name: 'WorksList',
  data() {
    return {
      works: [] as Work[],
    };
  },
  created() {
  },
  mounted() {
    this.fetchWorks();
  },
  methods: {
    async fetchWorks() {
      try {
        const response = await this.$api.get<Work[]>('/works');
        this.works = response.data;
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
