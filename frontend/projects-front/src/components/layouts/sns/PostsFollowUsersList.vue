<template>
    <div id="followed-relationships">
        <div v-if="users.length > 0">
            <div v-for="user in users" :key="user.id" class="thumb-wrapper comment-wrapper followed-wrapper">
                <a :href="`/posts/user_home/${user.id}`" class="followed-link">
                    <div class="post-name-wrapper">
                        <img v-if="user.image_url" :src="$baseURL + user.image_url" class="sns-thumb" alt="">
                        <img v-else src="@/assets/images/noimage.jpg" class="sns-thumb" alt="">
                        <p class="posts-user-name">{{ user.name }}</p>
                        <p>{{ user.username }}</p>
                    </div>
                </a>
                <PostsRelationships :post-user-id="user.id" :initial-is-following=" user.is_following"/>
            </div>
        </div>
        <div v-else>
            <p>フォロー中のユーザーはいません。誰かをフォローしてみましょう！</p>
            <img src="@/assets/images/wolf.png" class="profile-thumb" id="no-follow-thumb" alt="">
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue';
import type { User } from '@/types/user';
import PostsRelationships from './PostsRelationships.vue';

export default defineComponent({
    name: 'PostsFollowUsersList',
    components: {
        PostsRelationships,
    },
    props: {
        users: {
            type: Array as PropType<User[]>,
            default: () => []
        },
    },
});
</script>