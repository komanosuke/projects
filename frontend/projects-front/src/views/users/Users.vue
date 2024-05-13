<template>
    <LoginHeader/>
    <main>
        <div class="contents" id="login-con">
            <router-view></router-view>
        </div>
    </main>
    <LoginFooter/>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import LoginHeader from '../../components/layouts/login/LoginHeader.vue';
import LoginFooter from '../../components/layouts/login/LoginFooter.vue';

export default defineComponent({
    name: 'AppUsers',
    components: {
        LoginHeader,
        LoginFooter,
    },
    data() {
        return {
        };
    },
});
</script>