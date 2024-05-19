<template>
  <header id="top-header">
    <div id="hd-flex">
      <a href="/">
        <div class="hd-side pf-side">home</div>
      </a>
      <a href="/" class="pf-hd-center" id="hd-center">
        <div>Liberal Earth</div>
      </a>
      <template v-if="isAdminLoggedIn">
        <a href="/admin_logout" class="hd-side" @click.prevent="adminLogout">Admin Log out</a>
      </template>
      <template v-else>
        <template v-if="isLoggedIn">
          <a href="/logout" class="hd-side pf-side" @click.prevent="logout">Log out</a>
        </template>
        <template v-else>
          <a :style="loginBtnVisibility" href="/login" id="hd-right" class="hd-side pf-side">log in</a>
        </template>
      </template>
    </div>
  </header>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'LoginHeader',
  data() {
    return {
      isAdminLoggedIn: false,
      isLoggedIn: false,
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
    adminLogout() {
      localStorage.removeItem('adminToken');  // トークンをローカルストレージから削除
      this.isAdminLoggedIn = false;
      this.$router.push('/');
    },
    logout() {
      localStorage.removeItem('authToken');  // トークンをローカルストレージから削除
      this.isLoggedIn = false;
      alert('ログアウトしました。');
      window.location.href = '/';
    },
  }
});
</script>