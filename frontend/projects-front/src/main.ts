import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios';
import { isLoggedIn, isAdminLoggedIn, getAuthToken, getAdminToken } from './services/auth.js';

const API_END_POINT = process.env.VUE_APP_API_END_POINT;
const apiClient = axios.create({
    baseURL: API_END_POINT,
});
const app = createApp(App);
app.directive('smooth-scroll', {
    mounted(el, binding) {
        el.addEventListener('click', (event: Event) => {
            event.preventDefault();  // デフォルトの動作を停止
            const targetId = binding.value || el.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            console.log(targetElement);
            if (targetElement) {
                const top = targetElement.getBoundingClientRect().top + window.scrollY - 90;
                window.scrollTo({ top: top, behavior: 'smooth' });
            }
        });
    }
});
app.config.globalProperties.$getAuthToken = getAuthToken;
app.config.globalProperties.$getAdminToken = getAdminToken;
app.config.globalProperties.$isLoggedIn = isLoggedIn;
app.config.globalProperties.$isAdminLoggedIn = isAdminLoggedIn;
app.config.globalProperties.$api = apiClient; // 全コンポーネントで $api としてアクセス可能
app.config.globalProperties.$baseURL = process.env.VUE_APP_API_BASE_URL;

app.use(router).mount('#app')