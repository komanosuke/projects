<template>
    <div id="cxxsew-contents">
        <h1>- News -</h1>
        <p class="center">ここでは、CxxSewに関する最新のニュースをご覧いただけます。</p>  
        <NewsList />
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import NewsList from './NewsList.vue';

export default defineComponent({
    name: 'NewsIndex',
    components: {
        NewsList,
    },
});
</script>
    