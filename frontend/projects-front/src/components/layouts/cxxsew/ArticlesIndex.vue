<template>
    <div id="cxxsew-contents">
        <h1>- Articles -</h1>
        <p class="center">ここでは、CxxSewのデザイナーによる写真や文章をブログ形式でご覧いただけます。</p>  
        <ArticlesList />
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import ArticlesList from './ArticlesList.vue';

export default defineComponent({
    name: 'ArticlesIndex',
    components: {
        ArticlesList,
    },
});
</script>
    