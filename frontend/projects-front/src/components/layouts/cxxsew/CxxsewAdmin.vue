<template>
    <!-- <div id="flash">{{ notice }}</div> -->
    <div id="cxxsew-contents">
        <div class="article">
            <h1>- 管理画面 -</h1>
        </div>
        <p>データ内容を選択して一覧表示・編集</p>
        <div class="data-wrapper">
            <div class="btn"><a href="/cxxsew/admin/users">登録者</a></div>
        </div>
        <div class="data-wrapper">
            <div class="btn"><a href="/cxxsew/admin/work_cats">商品カテゴリー</a></div>
            <div class="btn"><a href="/cxxsew/admin/works">商品</a></div>
        </div>
        <div class="data-wrapper">
            <div class="btn"><a href="/cxxsew/admin/article_cats">記事カテゴリー</a></div>
            <div class="btn"><a href="/cxxsew/admin/articles">記事</a></div>
        </div>
        <div class="data-wrapper">
            <div class="btn"><a href="/cxxsew/admin/news_cats">ニュースカテゴリー</a></div>
            <div class="btn"><a href="/cxxsew/admin/news">ニュース</a></div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'CxxsewAdmin',
    data() {
        return {
        };
    },
});
</script>