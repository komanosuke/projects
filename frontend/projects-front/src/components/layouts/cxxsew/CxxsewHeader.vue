<template>
    <header>
        <div id="hd-flex">
            <a href="/cxxsew/index" class="pc">
                <div class="hd-side pink">home</div>
            </a>
            <div class="toggle-btn sp" @click="toggleMenu">
                <div id="cross">
                    <span class="menu-line-top" :class="{ 'open': isMenuOpen }"></span>
                    <span class="menu-line-middle" :class="{ 'open': isMenuOpen }"></span>
                    <span class="menu-line-bottom" :class="{ 'open': isMenuOpen }"></span>
                </div>
            </div>
            <a href="/cxxsew/index" id="hd-center">
                <div>Cxx</div>
                <img src="@/assets/images/logo.png" alt="">
                <div>Sew</div>
            </a>
            <!-- 管理者ログインの条件分岐 -->
            <div v-if="isAdminLoggedIn" class="hd-side" @click="adminLogout">Admin Log out</div>
            <div v-else>
                <!-- 一般ユーザーのログイン状態の条件分岐 -->
                <div v-if="isLoggedIn" class="hd-side pink" @click="logout">Log out</div>
                <a href="/login?redirect=/cxxsew/index" v-else>
                <div class="hd-side pink">log in</div>
                </a>
            </div>
        </div>
  </header>

    <div class="hidden sp" id="sp-bg" :class="{ 'open': isMenuOpen }"></div>
        <div class="hidden sp" id="sp-menu" :class="{ 'open': isMenuOpen }">
            <h1 class="menu-h2">- Menu -</h1>
            <div class="explain">
            <div class="rect-wrapper">
                <div class="rect-row">
                <a href="/cxxsew/concept"><p>CONCEPT</p></a>
                <a href="/cxxsew/news"><p>NEWS</p></a>
                </div>
                <div class="rect-row">
                <a href="/cxxsew/works"><p>WORKS</p></a>
                <a href="/cxxsew/articles"><p>ARTICLES</p></a>
                </div>
            </div>
            </div>
            <div class="explain">
                <div class="rect-wrapper" id="sub-menu2">
                    <a href="/cxxsew/help">HELP</a>
                    <a href="/cxxsew/contact">CONTACT</a>
                    <a href="/cxxsew/policy">POLICY</a>
                    <a href="/cxxsew/terms">TERMS</a>
                </div>
            </div>
        <div id="menu-close">×</div>
    </div>

    <!-- カートに商品があるかの条件分岐 -->
    <a href="/cxxsew/purchase" id="cart-sign" v-if="cartPresent && cartWorksLength !== 0">
        <img src='/images/cart.png' alt="">
    </a>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'CxxsewHeader',
    data() {
        return {
            isAdminLoggedIn: false,
            isLoggedIn: false,
            isMenuOpen: false,
            cartPresent: false, // カートの存在状態
            cartWorksLength: 0, // カート内の商品数
        };
    },
    created() {
        this.isLoggedIn = this.$isLoggedIn();
        this.isAdminLoggedIn = this.$isAdminLoggedIn();
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
            alert('ログアウトしました。');
            this.$router.push('/cxxsew/index');
        },
    },
});
</script>