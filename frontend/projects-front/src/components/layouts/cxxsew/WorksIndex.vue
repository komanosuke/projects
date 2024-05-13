<template>
<div id="cxxsew-contents">
    <h1>- Works -</h1>
    <p class="center">ここでは、CxxSewの作品ラインナップをご覧いただけます。作品は本サイトでご注文いただけます。</p>  
    <WorksList />
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import WorksList from './WorksList.vue';

export default defineComponent({
  name: 'WorksIndex',
  components: {
    WorksList,
  },
});
</script>
