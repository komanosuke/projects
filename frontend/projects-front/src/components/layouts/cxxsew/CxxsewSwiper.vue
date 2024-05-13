<template>
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide"
        v-for="(image, index) in images"
        :key="index"
        :class="[
          { 'active': currentSlide === index },
        ]">
        <img :src="image.src" :class="image.class" alt="">
      </div>
    </div>
    <div class="swiper-pagination">
      <div
        class="swiper-pagination-bullet"
        v-for="(image, index) in images"
        :key="'bullet-' + index"
        :class="{ active: currentSlide === index }"
        @click="goToSlide(index)"
      ></div>
    </div>
    <!-- <div class="swiper-button-prev" @click="prevSlide">&lt;</div>
    <div class="swiper-button-next" @click="nextSlide">&gt;</div> -->
  </div>
</template>
  
<script lang="ts">
import { defineComponent } from 'vue';

interface Image {
  src: string;
  class: string;
}

export default defineComponent({
  data() {
    return {
      images: [] as Image[],
      currentSlide: 0 as number,
      autoSlideInterval: null as any,
    };
  },
  mounted() {
    this.images = [
      { src: `${this.$baseURL}/images/lion.jpeg`, class: 'main-photo' },
      { src: `${this.$baseURL}/images/tiger.jpeg`, class: 'main-photo fit-edit' },
      { src: `${this.$baseURL}/images/fox.jpeg`, class: 'main-photo' },
      { src: `${this.$baseURL}/images/black_panther.jpeg`, class: 'main-photo fit-edit' },
    ];
    this.startAutoSlide();
  },
  created() {
  },
  beforeUnmount() {
    clearInterval(this.autoSlideInterval);
  },
  methods: {
    startAutoSlide() {
      this.autoSlideInterval = setInterval(this.nextSlide, 4000);
    },
    goToSlide(index: number) {
      this.currentSlide = index;
    },
    nextSlide() {
      if (this.currentSlide < this.images.length - 1) {
        this.currentSlide += 1;
      } else {
        this.currentSlide = 0; // 最後のスライドに達したら最初に戻る
      }
    },
  }
});
</script>