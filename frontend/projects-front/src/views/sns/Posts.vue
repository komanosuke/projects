<template>
    <body id="sns-body">
        <SnsHeader />
        <main>
            <div class="side-bar pc">
                <SideBar />
            </div>
            <router-view></router-view>
        </main>
        <SnsFooter />
    </body>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import SnsHeader from '../../components/layouts/sns/SnsHeader.vue';
import SnsFooter from '../../components/layouts/sns/SnsFooter.vue';
import SideBar from '../../components/layouts/sns/SideBar.vue';
import '@/assets/stylesheets/sns/sns.css';

export default defineComponent({
    name: 'AppPosts',
    components: {
        SnsHeader,
        SnsFooter,
        SideBar,
    },
    data() {
        return {
        };
    },
});
</script>