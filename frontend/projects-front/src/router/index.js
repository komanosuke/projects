import { createRouter, createWebHistory } from 'vue-router';
import { isLoggedIn, isAdminLoggedIn } from '../services/auth.js';
import HomeIndex from '../views/HomeIndex.vue';
import NotFound from '../views/NotFound.vue';
import LogIn from '../views/login/LogIn.vue';
import Cxxsew from '../views/cxxsew/Cxxsew.vue';
import Posts from '../views/sns/Posts.vue'
import Education from '../views/education/Education.vue'
import Money from '../views/money/Money.vue'
import Mobile from '../views/mobile/Mobile.vue'
import Media from '../views/media/Media.vue'
import Users from '../views/users/Users.vue'

import UsersNew from '@/components/layouts/users/UsersNew.vue'
import UsersShow from '@/components/layouts/users/UsersShow.vue'
import UsersActivateAccount from '@/components/layouts/users/UsersActivateAccount.vue'
import UsersPasswordResetNew from '@/components/layouts/users/UsersPasswordResetNew.vue'
import UsersPasswordReset from '@/components/layouts/users/UsersPasswordReset.vue'

import CxxsewIndex from '@/components/layouts/cxxsew/CxxsewIndex.vue'
import WorksIndex from '@/components/layouts/cxxsew/WorksIndex.vue'
import WorksShow from '@/components/layouts/cxxsew/WorksShow.vue'
import ArticlesIndex from '@/components/layouts/cxxsew/ArticlesIndex.vue'
import ArticlesShow from '@/components/layouts/cxxsew/ArticlesShow.vue'
import NewsIndex from '@/components/layouts/cxxsew/NewsIndex.vue'
import NewsShow from '@/components/layouts/cxxsew/NewsShow.vue'
import CxxsewAdmin from '@/components/layouts/cxxsew/CxxsewAdmin.vue'
import CxxsewAdminLogin from '@/components/layouts/cxxsew/CxxsewAdminLogin.vue'
import CxxsewAdminView from '@/components/layouts/cxxsew/CxxsewAdminView.vue'
import CxxsewConcept from '@/components/layouts/cxxsew/CxxsewConcept.vue'
import CxxsewPurchase from '@/components/layouts/cxxsew/CxxsewPurchase.vue'
import CxxsewThanks from '@/components/layouts/cxxsew/CxxsewThanks.vue'
import CxxsewHelp from '@/components/layouts/cxxsew/CxxsewHelp.vue'
import CxxsewTerms from '@/components/layouts/cxxsew/CxxsewTerms.vue'
import CxxsewPolicy from '@/components/layouts/cxxsew/CxxsewPolicy.vue'
import ContactNew from '@/components/layouts/cxxsew/ContactNew.vue'
import ContactDone from '@/components/layouts/cxxsew/ContactDone.vue'

import PostsIndex from '@/components/layouts/sns/PostsIndex.vue'
import PostsShow from '@/components/layouts/sns/PostsShow.vue'
import PostsNew from '@/components/layouts/sns/PostsNew.vue'
import PostsUserHome from '@/components/layouts/sns/PostsUserHome.vue'
import PostsFollowed from '@/components/layouts/sns/PostsFollowed.vue'
import PostsFollowers from '@/components/layouts/sns/PostsFollowers.vue'

import EducationJapanese from '@/components/layouts/education/EducationJapanese.vue'
import EducationMath from '@/components/layouts/education/EducationMath.vue'
import EducationSocial from '@/components/layouts/education/EducationSocial.vue'
import EducationScience from '@/components/layouts/education/EducationScience.vue'
import EducationEnglish from '@/components/layouts/education/EducationEnglish.vue'
import EducationKanji from '@/components/layouts/education/EducationKanji.vue'
import EducationCollection from '@/components/layouts/education/EducationCollection.vue'
import EducationSpeak from '@/components/layouts/education/EducationSpeak.vue'

const routes = [
  { path: '/', component: HomeIndex },
  {
    path: '/:pathMatch(.*)*', // すべての未知のパスにマッチ
    name: 'NotFound',
    component: NotFound,
  },
  { path: '/login', component: LogIn },
  { path: '/users', component: Users, redirect: '/',
    children: [
      { path: 'new', component: UsersNew },
      { path: ':id(\\d+)', component: UsersShow, props: true, meta: { requiresAuth: true } },
      { path: 'activate/:token', component: UsersActivateAccount, props: true },
      { path: 'password_reset', component: UsersPasswordResetNew },
      { path: 'password_reset/:token', component: UsersPasswordReset, props: true },
    ],
  },
  { path: '/cxxsew', component: Cxxsew, redirect: '/cxxsew/index',
    children: [
      { path: 'admin_login', component: CxxsewAdminLogin },
      { path: 'admin', component: CxxsewAdmin, meta: { requiresAdmin: true } },
      { path: 'admin/:model', component: CxxsewAdminView, props: true, meta: { requiresAdmin: true } },

      { path: 'index', component: CxxsewIndex },
      { path: 'works', component: WorksIndex },
      { path: 'works/:id(\\d+)', component: WorksShow, props: true },
      { path: 'articles', component: ArticlesIndex },
      { path: 'articles/:id(\\d+)', component: ArticlesShow, props: true },
      { path: 'news', component: NewsIndex },
      { path: 'news/:id(\\d+)', component: NewsShow, props: true },
      { path: 'concept', component: CxxsewConcept },
      { path: 'purchase', component: CxxsewPurchase },
      { path: 'thanks', component: CxxsewThanks },
      { path: 'help', component: CxxsewHelp },
      { path: 'terms', component: CxxsewTerms },
      { path: 'policy', component: CxxsewPolicy },
      { path: 'contact', component: ContactNew },
      { path: 'contact_done', component: ContactDone },
    ],
  },
  { path: '/posts', component: Posts, redirect: '/posts/index',
    children: [
      { path: 'index', component: PostsIndex },
      { path: 'new', component: PostsNew, meta: { requiresAuth: true } },
      { path: 'user_home/:id(\\d+)', component: PostsUserHome, props: true, meta: { requiresAuth: true } },
      { path: 'followed/:id(\\d+)', component: PostsFollowed, props: true, meta: { requiresAuth: true } },
      { path: 'followers/:id(\\d+)', component: PostsFollowers, props: true, meta: { requiresAuth: true } },
      { path: ':id(\\d+)', component: PostsShow, props: true, meta: { requiresAuth: true } },
    ],
  },
  { path: '/education', component: Education,
    children: [
      { path: 'japanese', component: EducationJapanese },
      { path: 'math', component: EducationMath },
      { path: 'social', component: EducationSocial },
      { path: 'science', component: EducationScience },
      { path: 'english', component: EducationEnglish },
      { path: 'kanji/:grade', component: EducationKanji, props: true },
      { path: 'collection', component: EducationCollection },
      { path: 'speak', component: EducationSpeak },
    ],
  },
  { path: '/money', component: Money },
  { path: '/mobile', component: Mobile },
  { path: '/media', component: Media },

  // {
  //   path: '/secret',
  //   name: 'SecretPage',
  //   component: SecretPage,
  //   meta: { requiresAuth: true }  // このページが認証を要求することを示す
  // },
];

const router = createRouter({
  history: createWebHistory(process.env.VUE_APP_BASE_URL),
  routes,
});

// ナビゲーションガードをグローバルに設定
router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAdmin)) {
    // 管理者権限が必要なページへのアクセス制御
    if (!isAdminLoggedIn()) {
      next({
        path: '/cxxsew/admin_login',
        query: { redirect: to.fullPath }
      });
    } else {
      next();
    }
  } else if (to.matched.some(record => record.meta.requiresAuth)) {
    // 通常のユーザー用ログインページへのリダイレクト
    if (!isLoggedIn()) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      });
    } else {
      next();
    }
  } else {
    next(); // 認証が不要なページ
  }
});

export default router;