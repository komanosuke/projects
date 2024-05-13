<template>
<div id="cxxsew-contents">
    <div class="article">
        <h1>- Help -</h1>
        
        <div class="questions">
            <p>◆よくある質問</p>
            <div class="q-wrapper" v-for="(item, index) in faqList" :key="index" :item="item">
                <div class="question">
                    Q. {{ item.question }}
                </div>
                <div class="answer">
                    A. {{ item.answer }}
                </div>
            </div>
        </div>
    </div>
</div>


</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'CxxsewHelp',
    data() {
        return {
            faqList: [
                { question: '実店舗はありますか。', answer: 'オンラインでのみ購入いただけます。' },
                { question: '商品の返品方法を教えてください。', answer: '商品受取後7日以内にメールまたはお問い合わせフォームからご連絡ください。' },
                { question: '支払い方法にはどのようなものがありますか？', answer: 'クレジットカード、銀行振込、コンビニ支払いがご利用いただけます。' },
                { question: '配送にかかる時間はどのくらいですか？', answer: '通常、注文後3〜5営業日でお届けします。' },
            ],
        };
    },
});
</script>