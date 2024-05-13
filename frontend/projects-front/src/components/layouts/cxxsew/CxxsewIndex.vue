<template>
<CxxsewSwiper />
<div id="cxxsew-contents">
    <div class="article">
        <h1>- CxxSewの挑戦 -</h1>
        <div class="article-flex">
            <div class="article-p-wrapper">
                <p>石川県金沢市出身のデザイナーたちが立ち上げたCxxSew（シーソウ）は、「ニヒリズムの脱却」をテーマとしたファッションブランドです。</p>
                <p>ブランド名は、現代衣服の意義を表しています。思いや考え（=C[Concepts]）がかけ合わさり（=xx）、縫い合わさる（=Sew）ことで衣服は作られているという意味です。</p>
                <p>このような「意思表示としての衣服のあり方」が注目されて久しいですが、CxxSewでは、特に「ニヒリズムの脱却」、つまり「目的ある人生」を実現するための衣服を目指しています。</p>
            </div>
            <div class="article-img-wrapper">
                <img src="@/assets/images/cxxsew.jpeg" alt="">
            </div>
        </div>
        <h2>- 人間疎外とニヒリズム -</h2>
        <div class="article-flex">
            <div class="article-p-wrapper" id="child2">
                <p>
                    あなたは社会が冷たくなったと感じたことはないでしょうか。自分は大切にされていないと感じたことはないでしょうか。
                    失敗への恐れや無力感から、挑戦を諦めたことはないでしょうか。
                </p>
                <p>現代社会では、科学技術によるシステム化や経済合理性の追求により、たびたび「人間疎外」が指摘されています。</p>
                <p>
                    最近では人工知能の発展によって、機械が人間の能力のほとんどを代替できるようになる未来が見えてきました。
                    歴史上比類ないほど豊かな社会が実現しそうである一方で、
                    「がんばっても報われないし、人生はただの暇つぶしだ」と考えるニヒリズム的な思想を持つ人も増えているようです。
                </p>
            </div>
            <div class="article-img-wrapper" id="child1">
                <img src="@/assets/images/anti_nihilism.jpeg" alt="">
            </div>
        </div>
        <h2>- ニヒリズムの脱却 -</h2>
        <p>
            哲学者ニーチェは、強い意志をもった「超人」となることでニヒリズムから脱却できると説きましたが、人間は弱いものです。
            一人では寂しく、気力も長くはもちません。現実に心を折られたり、目先の欲にかられて目的を忘れてしまったりすることもあるでしょう。
        </p>
        <p>
            現状を打開すべく、私たちは衣服による「ニヒリズムの脱却」に挑戦しています。
            いつも私たちのそばにある衣服は、大切なメッセージを忘れないようにしてくれます。
            CxxSewの思いとあなたの思いをかけ合わせて衣服にすれば、常に「人生の目的」を身にまとうことができます。
        </p>
        <p>
            他人より美しくなくても、強くなくても、有能でなくても大丈夫です。CxxSewは、「自分の価値は自分で決める」というメッセージを込めています。
            あなたが自分自身を大切にし、自分の人生の目的を見つけることを願っています。
        </p>
        <div class="btn pink"><a href="/cxxsew/concept">Know More</a></div>
        <div>
            <img src="@/assets/images/overcome.jpeg" class="large-img" alt="">
        </div>
    </div>
    
    <h2>- Works -</h2>
    <p>動物のアートには大自然を生きる生命力を感じます。ぜひご覧ください。作品は本サイトでご注文いただけます。</p>
    <p class="subtext">◆のついているものは、一点物のハンドメイド作品です。</p>
    <WorksList />
    <div class="btn pink"><a href="/cxxsew/works">View More</a></div>

    <h2>- Site Map -</h2>
    <p>
        ご興味をもっていただけましたら、ぜひ以下のリンクから本サイト内を探検してみてください。
    </p>
    <div class="explain">
        <div class="rect-wrapper">
            <div class="rect-row">
                <a href="/cxxsew/concept"><p>CONCEPT</p></a>
                <a href="/cxxsew/news"><p>NEWS</p></a>
            </div>
            <div class="rect-row">
                <a href="/cxxsew/works"><p>WORKS</p></a>
                <a href="/cxxsew/articles"><p>ARTICLES</p></a>
            </div>
        </div>
    </div>

    <h2>- Concept Movie -</h2>
    <p>私たちの伝えたいことをシンプルな動画にまとめました。</p>
    <video controls :poster="imageUrl('/images/fashion_movie.jpeg')" id="concept-movie">
        <source src="@/assets/movies/fashion_movie.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>
</div>
</template>


<script lang="ts">
import { defineComponent } from 'vue';
import CxxsewSwiper from './CxxsewSwiper.vue';
import WorksList from './WorksList.vue';

export default defineComponent({
  name: 'CxxsewIndex',
  data() {
    return {
    };
  },
  components: {
    CxxsewSwiper,
    WorksList,
  },
  methods: {
    imageUrl(url: string): string {
      return this.$baseURL + url;
    },
  },
});
</script>