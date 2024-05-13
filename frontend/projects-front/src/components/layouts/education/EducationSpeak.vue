<template>
    <div>
        <video id="doraemon-video" src="@/assets/movies/doraemon.mp4" poster="@/assets/movies/doraemon.jpg" loop></video>
        <textarea v-model="inputText" id="text-to-speak" rows="10" cols="50" placeholder="ここに読み上げたいテキストを入力してください。"></textarea>
        <button @click="speakInputText()">読み上げ開始</button>
        <input v-model="inputUrl" id="text-to-speak" placeholder="ここにURLを貼るとそのページの内容を要約して読み上げます。">
        <button @click="fetchHtmlSammary()">リクエスト</button>
        <div>{{ responseText }}</div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { AxiosError } from 'axios';

interface ErrorResponse {
    error: string;
    status: number;
}

export default defineComponent({
    name: 'EducationSpeak',
    data() {
        return {
            inputText: '',
            inputUrl: '',
            responseText: '',
        };
    },
    methods: {
        speakText(text: string) {
            let video = document.getElementById('doraemon-video') as HTMLVideoElement;
            video.play(); // ビデオを再生
            // 読み上げ中に再度ボタンが押された場合、現在の読み上げとビデオを停止
            if (window.speechSynthesis.speaking) {
                window.speechSynthesis.cancel(); // 読み上げを停止
                video.pause(); // ビデオを停止
                video.currentTime = 0; // ビデオを最初から再開するために時間をリセット
            }

            // テキストエリアからテキストを取得
            let utterance = new SpeechSynthesisUtterance(text);
            utterance.lang = "ja-JP";

            // 読み上げ終了後にビデオを停止
            utterance.onend = function() {
                video.pause();
                video.currentTime = 0;
            };

            // テキストを読み上げる
            window.speechSynthesis.speak(utterance);
        },
        speakInputText() {
            this.speakText(this.inputText);
        },
        async fetchHtmlSammary() {
            if (!this.inputUrl) {
                alert('URLを入力してください。');
                return;
            }
            try {
                const response = await this.$api.get('/html', {
                    params: {
                        url: this.inputUrl
                    }
                });
                this.responseText = response.data.text;
                console.log(response.data.text);
                this.speakText(this.responseText);
            } catch (error) {
                const axiosError = error as AxiosError<ErrorResponse>;
                if (axiosError.response) {
                    console.log(axiosError.response.data.error);
                    console.error('Error:', axiosError.response.data.error);
                    console.error('Status code:', axiosError.response.data.status);
                    if (!axiosError.response.data.error) {
                        console.error('Response:', axiosError.response.data);
                    }
                } else if (axiosError.request) {
                    console.error('Error: No response received.');
                } else {
                    console.error('Error:', axiosError.message);
                }
                // サーバーからの応答がある場合、エラーメッセージをログに出力
                // if (axiosError.response) {
                //     console.error('Error:', axiosError.response.data.error);
                //     console.error('Status code:', axiosError.response.status);
                //     // 応答があるが、エラーメッセージがない場合は応答全体をログに出力
                //     if (!axiosError.response.data.error) {
                //         console.error('Response:', axiosError.response.data);
                //     }
                // } else if (axiosError.request) {
                //     // リクエストは送信されたが、応答を受け取れなかった場合
                //     console.error('Error: No response received.');
                // } else {
                //     // エラーを設定する際に問題が発生した場合
                //     console.error('Error:', axiosError.message);
                // }
            }
        },
    },
});
</script>