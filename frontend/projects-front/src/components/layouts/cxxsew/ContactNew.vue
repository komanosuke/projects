<template>
    <div id="overlay" v-if="overlay">
        <div class="loader"></div>
    </div>
    <div id="cxxsew-contents">
        <div class="article">
            <h1>- Contact -</h1>
            <form @submit.prevent="submitForm">
                <label for="subject">件名<span class="required">必須</span></label>
                <select ref="subjectSelect" v-model="form.subject" @change="checkValidation" required autofocus id="contact-select">
                    <option disabled selected value="">選択してください</option>
                    <option v-for="(value, key) in subjects" :key="key" :value="value">{{ value }}</option>
                </select>

                <label for="name">お名前<span class="required">必須</span></label>
                <input type="text" v-model="form.name" maxlength="40" placeholder="お名前を入力してください" required>

                <label for="email">メールアドレス<span class="required">必須</span></label>
                <input type="email" v-model="form.email" maxlength="40" placeholder="メールアドレスを入力してください" required>

                <label for="phone_number">お電話番号<span class="required">必須</span></label>
                <input type="text" v-model="form.phone_number" maxlength="40" placeholder="電話番号を入力してください" required>

                <label for="message">お問い合わせ内容<span class="required">必須</span></label>
                <textarea v-model="form.message" placeholder="お問い合わせ内容を入力してください" required></textarea>

                <button type="submit" class="btn" id="submit-btn">送信</button>
            </form>
        </div>
        <div id="popup" v-if="showPopup" @click="closePopup" class="popup-overlay">
            <div class="popup-content" @click.stop>
                <h2>お問い合わせ確認</h2>
                <div class="form-item">
                    <label>件名:</label>
                    <p>{{ form.subject }}</p>
                </div>
                <div class="form-item">
                    <label>お名前:</label>
                    <p>{{ form.name }}</p>
                </div>
                <div class="form-item">
                    <label>メールアドレス:</label>
                    <p>{{ form.email }}</p>
                </div>
                <div class="form-item">
                    <label>電話番号:</label>
                    <p>{{ form.phone_number }}</p>
                </div>
                <div class="form-item">
                    <label>内容:</label>
                    <p class="textarea-content">{{ form.message }}</p>
                </div>
                <button @click="submitForm" type="submit" class="btn" id="submit-btn">この内容で送信</button>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'ContactNew',
    data() {
        return {
            form: {
                subject: '',
                name: '',
                email: '',
                phone_number: '',
                message: ''
            },
            subjects: {},
            showPopup: false,
            overlay: false,
        };
    },
    mounted() {
        this.fetchSubjects();
    },
    methods: {
        checkValidation() {
            const selectElement = this.$refs.subjectSelect as HTMLSelectElement;
            if (!this.form.subject) {
                selectElement.setCustomValidity("件名を選択してください。");
            } else {
                selectElement.setCustomValidity(""); // バリデーションエラーをクリア
            }
            selectElement.reportValidity(); // バリデーションメッセージを強制表示
        },
        async submitForm() {
            this.checkValidation();
            if (!this.form.subject) return;

            if(this.showPopup) {
                const response = await this.sendMail();
                if (response === 'success') {
                    this.$router.push('/cxxsew/contact_done');
                }
            } else {
                this.showPopup = true;
            }
        },
        async sendMail(): Promise<string | null> {
            this.overlay = true;
            try {
                const response = await this.$api.post('/contacts', this.form);
                if (response.data.status === 'success') {
                    return 'success';
                } else {
                    alert('送信失敗: ' + response.data.message);
                    return null;
                }
            } catch (error) {
                alert('通信エラーが発生しました。');
                return null;
            } finally {
                this.overlay = false;
            }
        },
        async fetchSubjects() {
            try {
                const response = await this.$api.get('/contacts/subject');
                this.subjects = response.data;
            } catch (error) {
                console.error(error);
            }
        },
        imageUrl(url: string): string {
            return this.$baseURL + url;
        },
        closePopup() {
            this.showPopup = false;
        },
    },
});
</script>

<style scoped>
.popup-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 998;
}

.popup-content {
    background: #fff;
    padding: 20px;
    width: 80vw;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    max-height: 70%;
    overflow-y: auto;
}

.popup-content h2 {
    margin-top: 0 !important;
}

.popup-content #submit-btn {
    margin-bottom: 0;
}

.form-item {
    display: flex;
    margin: 0 auto 10px;
    width: 80%;
    align-items: stretch;
}

.form-item label {
    font-weight: bold;
    width: 200px;
    min-height: 30px;
    background: indianred;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px;
}

.form-item p {
    width: calc(100% - 20px);
    margin: 0;
    background: rgb(229, 168, 168);
    min-height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    word-break: break-word;
    padding: 10px;
}

@media screen and (max-width:750px) {
    .form-item {
        display: block;
        width: 100%;
    }

    .form-item label {
        width: calc(100% - 20px);
        min-height: 10px;
    }

    .form-item p {
        min-height: 10px;
    }
}
</style>