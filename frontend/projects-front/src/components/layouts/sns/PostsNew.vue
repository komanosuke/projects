<template>
    <div class="contents" id="sns-contents">
        <h1>- 新規投稿作成 -</h1>
        <form class="sns-form" @submit.prevent="createPost">
            <label for="content"></label>
            <textarea v-model="postContent" required></textarea>
            <div class="btn sns-btn" id="add-post-image" @click="showImageInput">画像を追加する</div>
            <div v-show="showImageInputField" id="image-option">
                <input type="file" id="sns-img-file" accept="image/*" @change="handleImageUpload">
                <div id="post-preview">
                    <p>--- Preview ---</p>
                    <img :src="previewImageUrl" id="post-image" alt="">
                </div>
            </div>
            <button type="submit" class="sns-btn">作成</button>
            <div>{{ message }}</div>
        </form>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'PostsNew',
    data() {
        return {
            postContent: '',
            showImageInputField: false,
            previewImageUrl: `${this.$baseURL}/images/noimage.jpg`,
            uploadedImage: null as File | null,
            message: '',
        };
    },
    methods: {
        async createPost() {
            const formData = new FormData();
            formData.append('post[content]', this.postContent);
            if (this.uploadedImage) {
                formData.append('post[image]', this.uploadedImage);
            }

            try {
                const response = await this.$api.post('/posts', formData, {
                    headers: {
                        'Authorization': `Bearer ${this.$getAuthToken()}`,
                    },
                });
                console.log('Post created successfully:', response);
                this.message = response.data.message;
                this.$router.push('/posts');
            } catch (error) {
                console.error('Error creating post:', error);
                this.message = '投稿作成に失敗しました。';
            }
        },
        showImageInput() {
            this.showImageInputField = true;
        },
        handleImageUpload(event: Event) {
            const input = event.target as HTMLInputElement;
            if (input && input.files && input.files[0]) {
                const file = input.files[0];
                this.uploadedImage = file;
                this.previewImageUrl = URL.createObjectURL(file);
            }
        },
    },
});
</script>