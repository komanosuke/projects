<template>
    <header>
        <div id="hd-flex" @click="toggleMenu">
            <a href="/">
                <div class="hd-side pc sns-hd-side">home</div>
            </a>
            <div class="toggle-btn sp" id="sns-tgl">
                <div id="cross">
                    <span class="menu-line-top"></span>
                    <span class="menu-line-middle"></span>
                    <span class="menu-line-bottom"></span>
                </div>
            </div>
            <a href="/posts/index" id="hd-center">
                <div>Designers SNS</div>
            </a>
            <div v-if="isAdminLoggedIn" class="hd-side" @click="adminLogout">Admin Log out</div>
            <div v-else>
                <!-- 一般ユーザーのログイン状態の条件分岐 -->
                <div v-if="isLoggedIn" class="hd-side sns-hd-side" @click="logout">Log out</div>
                <a href="/login" v-else>
                    <div class="hd-side sns-hd-side">log in</div>
                </a>
            </div>
        </div>
    </header>
    <div class="hidden sp" id="sp-bg" :class="{ 'open': isMenuOpen }"></div>
    <div class="hidden sp" id="sp-menu" :class="{ 'open': isMenuOpen }">
        <h1 class="menu-h2">- Menu -</h1>
        <div class="side-bar sp" id="sp-side-bar">
            <SideBar />
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import SideBar from './SideBar.vue';

export default defineComponent({
    name: 'LoginHeader',
    components: {
        SideBar,
    },
    data() {
        return {
            isAdminLoggedIn: false,
            isLoggedIn: false,
            isMenuOpen: false,
        }
    },
    created() {
        this.isLoggedIn = this.$isLoggedIn();
        this.isAdminLoggedIn = this.$isAdminLoggedIn();
    },
    computed: {
        loginBtnVisibility(): string {
            return this.isLoggedIn || this.$route.path !== "/login" ? 'visibility:visible;' : 'visibility:hidden;';
        },
    },
    methods: {
        toggleMenu() {
            this.isMenuOpen = !this.isMenuOpen;
        },
        adminLogout() {
            localStorage.removeItem('adminToken');  // トークンをローカルストレージから削除
            this.isAdminLoggedIn = false;
            this.$router.push('/');
        },
        logout() {
            localStorage.removeItem('authToken');  // トークンをローカルストレージから削除
            this.isLoggedIn = false;
            this.$router.push('/');
        },
    }
});
</script>