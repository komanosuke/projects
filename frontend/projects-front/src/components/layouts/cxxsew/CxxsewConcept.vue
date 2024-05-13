<template>
    <div id="cxxsew-contents">
        <div class="article">
            <h1>- CxxSewのコンセプト -</h1>
            
            <p>石川県金沢市出身のデザイナーたちが立ち上げたCxxSew（シーソウ）は、「ニヒリズムの脱却」をテーマとしたファッションブランドです。</p>
            <p>ブランド名は、現代衣服の意義を表しています。思いや考え（=C[Concepts]）がかけ合わさり（=xx）、縫い合わさる（=Sew）ことで衣服は作られているという意味です。</p>
            <p>このような「意思表示としての衣服のあり方」が注目されて久しいですが、CxxSewでは、特に「ニヒリズムの脱却」、つまり「目的ある人生」を実現するための衣服を目指しています。</p>
            <p>ここでは、より詳しくCxxSewのコンセプトについて綴ります。</p>
            
            <ul class="concept-lists">
                <li>
                    <p class="c-title">- Concept -</p>
                    <div v-for="link in links" :key="link.id">
                        <p><a :href="`#${link.id}`" v-smooth-scroll="link.id">{{ link.text }}</a></p>
                    </div>
                    <p class="c-title">- - - - - - - -</p>
                </li>
            </ul>

            <div v-for="section in sections" :key="section.id">
                <h2 :id="section.id">{{ section.title }}</h2>
                <div class="article-flex">
                    <template v-if="section.reverse">
                        <div class="article-img-wrapper">
                            <div v-if="section.imagePath">
                                <img :src="$baseURL + section.imagePath" alt="">
                            </div>
                        </div>
                        <div class="article-p-wrapper">
                            <p v-for="(content, index) in section.content" :key="index">{{ content }}</p>
                        </div>
                    </template>
                    <template v-else>
                        <div class="article-p-wrapper">
                            <p v-for="(content, index) in section.content" :key="index">{{ content }}</p>
                        </div>
                        <div class="article-img-wrapper">
                            <div v-if="section.imagePath">
                                <img :src="$baseURL + section.imagePath" alt="">
                            </div>
                        </div>
                    </template>
                </div>
            </div>
            <h2 id="c-6">- 6. ニヒリズムを乗り越える -</h2>
            <div class="article-flex">
                <div>
                    <p>
                        CxxSewはあなたの「人生の目的」を応援する「仲間」でありたいと思っています。
                        これからは自分の好きなものを通してゆるやかな「つながり」をつくっていく時代です。
                        衣服を通して共感してくれる「仲間」が増え、ともにニヒリズムを乗り越えていけることを願っています。
                    </p>
                </div>
            </div>

            <p class="concept-end">以上がファッションブランドCxxSewのコンセプトです。共感していただけた方は、以下のボタンから作品のラインナップをぜひご覧ください。</p>
            <div class="btn pink" id="submit-btn"><a href="/cxxsew/works">Works</a></div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

const sectionData = [
    {
        id: 'c-1',
        title: '- 1. ひもで構成される世界 -',
        content: [
            '私たちが生きているこの宇宙は無から生まれたと言われています。無の中でも、素粒子が生まれたり消滅したりしていたようです。',
            '素粒子はゆらゆらした「ひも」のようなもので、そのゆれ方によって性質が変わります。原子や電子も素粒子から構成されています。',
            'つまり全ての存在は「ひも」でできていることになります。'
        ],
        imagePath: '/images/strings.jpeg',
        reverse: false,
    },
    {
        id: 'c-2',
        title: '- 2. 糸で構成される衣服 -',
        content: [
            '世界は全て「ひも」でできているわけですが、これは衣服が糸から成り立つことに似ています。',
            'また糸といえば運命の赤い糸など、「縁」も連想されます。宇宙誕生のスケールで考えると、元を辿れば全てが縁でつながっています。',
            '「ひも」世界を構成するように、「糸」が衣服を構成するように、「人」をつないでニヒリズムを超えた社会を実現する、そんなファッションブランドでありたいと思っています。'
        ],
        imagePath: '/images/red_thread.png',
        reverse: true,
    },
    {
        id: 'c-3',
        title: '- 3. 時代もゆらいでいる -',
        content: [
            '時代もまた「ひも」のようにゆれています。仏教が諸行無常を説いたように、人間の活動にも流行りや廃りがあります。',
            'シーソーが交互にゆれるように、全てのものは波のようにいったりきたりしているのです。',
            'しかし芸術作品においては、その価値が時代を超えて認められているものもたくさん存在します。古典に書かれた処世術なども色褪せていません。'
        ],
        imagePath: '/images/wave.jpeg',
        reverse: false,
    },
    {
        id: 'c-4',
        title: '- 4. 時代をこえ愛される衣服 -',
        content: [
            '衣服は時代によって、その姿や役割を変えています。',
            '私たちはより善い世界を志向し、色褪せない「思想」を衣服にこめています。',
            'どんな時代が来ても「仲間」と「人生の目的」が人間に幸福をもたらす、という思想です。',
            '社会的な生物である人間にとって「仲間」の存在は必ず助けになります。',
            'また、「神が死んだ」現代では「人生の目的」が生きがいをもたらします。',
            'バーチャルが人間の欲望を全て解決する世界が来ても、人はそれらを求めるのではないでしょうか。'
        ],
        imagePath: '/images/love_fashion.png',
        reverse: true,
    },
    {
        id: 'c-5',
        title: '- 5. これからの衣服の役割 -',
        content: [
            'CxxSewでは、衣服が「思想をまとい、人生の目的のリマインダー」として活躍するという一面に注目しています。',
            'ご希望によりますが、CxxSewの衣服にはあなた自身の決意（人生の目的）を刻みこむことをおすすめしています。',
            '衣服を着るたびに、私たちからのエールを思い出していただけるのではないかと考えているからです。'
        ],
        imagePath: '/images/overcome.jpeg',
        reverse: false,
    },
];


const linkData = [
    { id: 'c-1', text: '1. ひもで構成される世界' },
    { id: 'c-2', text: '2. 糸で構成される衣服' },
    { id: 'c-3', text: '3. 時代もゆらいでいる' },
    { id: 'c-4', text: '4. 時代をこえ愛される衣服' },
    { id: 'c-5', text: '5. これからの衣服の役割' },
    { id: 'c-6', text: '6. ニヒリズムを乗り越える' },
];

export default defineComponent({
    name: 'CxxsewConcept',
    data() {
        return {
            sections: sectionData,
            links: linkData,
        };
    },
});
</script>

