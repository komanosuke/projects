<template>
<LoginHeader/>
<main>
    <div id="login-con" class="contents">
        <h1>404 エラー</h1>
        <p class="center">This page does not exist.</p>
        <p class="center">Liberal Earthをご利用いただきありがとうございます。<br>申し訳ありませんが、お探しのページが見つかりませんでした。<br>お探しのページは削除されたか、URLが変更された場合がございます。</p>
        <button type="submit" class="btn submit-btn"><a href="/">トップページへ</a></button>
    </div>
</main>
<LoginFooter/>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import LoginHeader from './../components/layouts/login/LoginHeader.vue';
import LoginFooter from './../components/layouts/login/LoginFooter.vue';

export default defineComponent({
    name: 'NotFound',
    components: {
        LoginHeader,
        LoginFooter,
    },
});
</script>