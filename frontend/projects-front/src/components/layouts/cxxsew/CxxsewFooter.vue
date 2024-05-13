<template>
  <footer>
    <a href="/cxxsew/index" id="ft-center">
      <div>Cxx</div>
        <img src="@/assets/images/logo_negate.png" alt="">
        <div>Sew</div>
    </a>
    <p>- Anti Nihilism Fashion Brand -</p>
    <!-- <p>石川県金沢市利家城下町100万石</p> -->
    <!-- <p>cxxsew_million@example.com</p> -->
    <div class="help-wrapper">
      <a href="/cxxsew/help">HELP</a>
      <a href="/cxxsew/contact">CONTACT</a>
      <a href="/cxxsew/policy">POLICY</a>
      <a href="/cxxsew/terms">TERMS</a>
    </div>
    <ul class="follow-links">
      <li class="follow-link">
        <a href="https://twitter.com" target="_blank">
          <img src="@/assets/svg/twitter_w.svg" alt="" class="icon" />
        </a>
      </li>
      <li class="follow-link">
        <a href="https://ja-jp.facebook.com" target="_blank">
          <img src="@/assets/svg/facebook_w.svg" alt="" class="icon" />
        </a>
      </li>
      <li class="follow-link">
        <a href="https://www.instagram.com" target="_blank">
          <img src="@/assets/svg/instagram_w.svg" alt="" class="icon" />
        </a>
      </li>
      <li class="follow-link">
        <a href="https://line.me" target="_blank">
          <img src="@/assets/svg/line_w.svg" alt="" class="icon" />
        </a>
      </li>
    </ul>
    <small>(C) 2023 CxxSew.Inc All Rights Reserved.</small>
  </footer>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'CxxsewFooter',
  data() {
    return {
    };
  },
});
</script>
