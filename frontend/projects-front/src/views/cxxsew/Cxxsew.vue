<template>
  <cxxsew-header />
  <main id="cxxsew-main">
    <div class="container">
      <div class="brand-theme">Anti Nihilism Fashion Brand</div>
      <router-view></router-view>
    </div>
  </main>
  <cxxsew-footer />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import CxxsewHeader from '../../components/layouts/cxxsew/CxxsewHeader.vue';
import CxxsewFooter from '../../components/layouts/cxxsew/CxxsewFooter.vue';

export default defineComponent({
  name: 'CxxSew',
  data() {
    return {
    };
  },
  components: {
    CxxsewHeader,
    CxxsewFooter,
  },
});
</script>