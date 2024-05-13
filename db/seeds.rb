User.create(name: 'Guest User', username: '@user', email: 'user@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町', address: '東京都〇〇区〇〇町', tel: '0000000000', profile: '', activated: true, photo: File.open("./public/images/skull.png"))
User.create(name: 'Dragon', username: '@dragon', image:File.open("./public/images/dragon.png"), email: 'dragon@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町', address: '東京都〇〇区〇〇町', tel: '0000000000', profile: '幻獣系デザイナーのドラゴンです。よろしくお願いします。', activated: true)
User.create(name: 'Gorilla', username: '@gorilla', image:File.open("./public/images/gorilla.png"), email: 'gorilla@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町', address: '東京都〇〇区〇〇町', tel: '0000000000', profile: '筋肉系デザイナーのゴリラです。よろしくお願いします。', activated: true)
User.create(name: 'Panda', username: '@panda', image:File.open("./public/images/panda.png"), email: 'panda@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町', address: '東京都〇〇区〇〇町', tel: '0000000000', profile: '珍獣系デザイナーのパンダです。よろしくお願いします。', activated: true)
User.create(name: 'Cat', username: '@cat', image:File.open("./public/images/cat.png"), email: 'cat@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町', address: '東京都〇〇区〇〇町', tel: '0000000000', profile: 'キュート系デザイナーのキャットです。よろしくお願いします。', activated: true)
User.create(name: 'Penguin', username: '@penguin', image:File.open("./public/images/penguin.png"), email: 'penguin@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町', address: '東京都〇〇区〇〇町', tel: '0000000000', profile: '癒し系デザイナーのペンギンです。よろしくお願いします。', activated: true)
Cart.create(user_id: 1)
Cart.create(user_id: 2)
Cart.create(user_id: 3)
Cart.create(user_id: 4)
Cart.create(user_id: 5)
Cart.create(user_id: 6)
StudyRecord.create(user_id: 1)
StudyRecord.create(user_id: 2)
StudyRecord.create(user_id: 3)
StudyRecord.create(user_id: 4)
StudyRecord.create(user_id: 5)
StudyRecord.create(user_id: 6)
Lifecost.create(user_id:1)
Lifecost.create(user_id:2)
Lifecost.create(user_id:3)
Lifecost.create(user_id:4)
Lifecost.create(user_id:5)
Lifecost.create(user_id:6)


WorkCat.create(name: 'トップス')
WorkCat.create(name: 'パンツ')
WorkCat.create(name: 'スカート')
WorkCat.create(name: 'ワンピース・ドレス')
WorkCat.create(name: 'サロペット・オールインワン')
WorkCat.create(name: 'セットアップアイテム')
WorkCat.create(name: 'アウター')
WorkCat.create(name: 'バッグ')
WorkCat.create(name: 'シューズ')
WorkCat.create(name: '帽子')
WorkCat.create(name: 'ファッション小物')
WorkCat.create(name: '財布・小物')
WorkCat.create(name: 'アクセサリー')
WorkCat.create(name: 'ヘアアクセサリー')

Work.create(work_cat_id: 1, title: '「獅子」', price:'13900', text: '強くて勇敢なリーダー、獅子。 このTシャツは、力強い存在感を放つ獅子をポリゴンアートで表現しています。 王者の風格をまとい、日々の生活に自信と威厳をもたらします。', onlyone: false, status: 1, image:File.open("./public/images/lion.jpeg"))
Work.create(work_cat_id: 1, title: '「龍」', price:'13900', text: '神秘的で力強い龍が舞い降りる。 幻想的な龍が空から力と知恵を運んでくるデザイン。古代の伝説を身に纏い、運命を切り開く力を感じてください。', onlyone: false, status: 1, image:File.open("./public/images/dragon.jpeg"))
Work.create(work_cat_id: 1, title: '「虎」', price:'13900', text: '野生の力と優美さを兼ね備えた虎。 このTシャツは、敏捷で力強い虎をモダンなポリゴンスタイルで描いています。 野生の美しさを日常に取り入れ、活力を与えます。', onlyone: false, status: 1, image:File.open("./public/images/tiger.jpeg"))
Work.create(work_cat_id: 1, title: '「亀」', price:'13900', text: '長寿と安定の象徴、亀。 穏やかで着実な歩みをポリゴンアートで表現したTシャツ。 長く深い時間を経て得た知恵と平和を、あなたにもたらします。', onlyone: false, status: 1, image:File.open("./public/images/turtle.jpeg"))
Work.create(work_cat_id: 1, title: '「鷲」', price:'13900', text: '高く舞い上がる鷲の姿。 空高く飛び立つ鷲をポリゴンスタイルで描いたTシャツ。 自由と独立の精神を高め、目標に向かって突き進む勇気を与えます。', onlyone: false, status: 1, image:File.open("./public/images/eagle.jpeg"))
Work.create(work_cat_id: 1, title: '「熊」', price:'13900', text: '迫力満点の熊。 勇敢で力強い熊をポリゴンアートで表現したこのTシャツは、あなたに大自然の力を感じさせます。野生の荒々しさを身に纏い、日常生活に勇気と自信をもたらす一枚です。', onlyone: false, status: 1, image:File.open("./public/images/bear.jpeg"))
Work.create(work_cat_id: 1, title: '「黒豹」', price:'13900', text: '神秘的で洗練された黒豹。 強さとスピードを秘めた黒豹を、洗練されたポリゴンスタイルでデザイン。 闇夜を駆け抜ける豪華な影のように、あなたの日常に新たな輝きを。', onlyone: false, status: 1, image:File.open("./public/images/black_panther.jpeg"))
Work.create(work_cat_id: 1, title: '「狐」', price:'13900', text: '賢くて機敏な狐。 このTシャツは、狡猾で敏速な狐の特徴をポリゴンアートスタイルで捉えています。鮮やかな赤色で描かれた狐が、その魅力的な眼差しと共に、あなたの日常にユニークなアクセントを加えます。', onlyone: false, status: 1, image:File.open("./public/images/fox.jpeg"))

ArticleCat.create(name: '制作')
ArticleCat.create(name: 'インスピレーション')

Article.create(article_cat_id: 2, image:File.open("./public/images/clothes11.png"), title: 'AIによるファッションデザイン', image_title: 'AIによるファッションデザインの例', text: 'AIの力を借りたファッションデザインが注目を集めています。従来の枠にとらわれない斬新なアイデアやデザインが生まれ、新たなトレンドを作り出しています。AIは膨大なデータを分析し、傾向や顧客の好みを把握することで、デザイナーに新たなインスピレーションをもたらします。これにより、より多様性のあるファッションが生まれ、個々のスタイルに合った選択肢が提供されることでしょう。')
Article.create(article_cat_id: 1, image:File.open("./public/images/world.jpeg"), title: '人間にしかできないデザインとは', image_title: 'カギは五感の共感？', text: 'ファッションデザインにおいて、人間の手による独自性や感性は不可欠です。デザイナーの創造力や経験から生まれるデザインには、独特の魅力や情熱が宿ります。人間の感性はAIでは再現できないものであり、デザイナーの個性がファッションに魂を吹き込むのです。そのため、人間にしかできないデザインは、ファッション界で永遠の存在となり続けるでしょう。')
Article.create(article_cat_id: 1, image:File.open("./public/images/designer.jpeg"), title: '衣服そのものではなく、デザイナーにファンがつく', image_title: '一個人としてのデザイナーの意見が心に訴える', text: 'ファッションブランドの魅力は、衣服そのものだけではありません。デザイナーの個性やストーリーに惹かれる人々が増えています。彼らはファッションを通じてデザイナーとのつながりを感じ、彼らの作品を応援します。SNSやイベントを通じて直接交流する機会も増え、ブランドとファンの関係はより密接になっています。衣服を通じてデザイナーの世界観や情熱に触れ、共感することで、より深いファッション体験を得ることができるのです。')
Article.create(article_cat_id: 2, image:File.open("./public/images/brand.png"), title: 'AI時代に向上するブランドの価値', image_title: 'デザインの飽和に対するブランドの希少性', text: 'AIの普及により、ブランドの価値観も変化しています。顧客は単に商品を求めるだけでなく、ブランドのエシカルな取り組みやサステナビリティに関心を持っています。AIを活用することで、効率的な生産や個別のニーズに対応することが求められます。ブランドはAIを活用して持続可能な材料や製造プロセスを探求し、環境負荷を減らす取り組みを行うことで、顧客からの支持を集めています。また、AIによるデータ分析や予測を駆使して、顧客の嗜好や需要を的確に把握し、より満足度の高い商品やサービスを提供することが重要です。AI時代に向上するブランドは、革新性と持続可能性を両立させることで、新たな価値を創造し続けるでしょう。')

NewsCat.create(name: 'テクノロジー')
NewsCat.create(name: '新情報')

News.create(news_cat_id: 2, image:File.open("./public/images/lion.jpeg"), title: '世界で一つのオーダーメイド商品の時代', image_title: '生成AIで作られた画像は唯一無二である', text: '新たなオーダーメイドの時代が幕を開けました。世界で一つだけの特別な商品を手に入れる喜びを感じてください。AI画像生成とあなたの個性が融合し、心躍る瞬間が訪れます。この特別な商品は、あなたのスタイルや好みを反映しており、一生の宝物となることでしょう。自分だけの世界に一つだけのアイテムを手に入れて、独自のファッションステートメントを楽しんでください。')
News.create(news_cat_id: 1, image:File.open("./public/images/clothes1.png"), title: 'AI時代の衣服との付き合い方', image_title: 'AIによりデザインされた衣服', text: 'AIの進化はファッション業界にも大きな変革をもたらしています。衣服はもはや単なる素材ではありません。AIがデザインやスタイリングのアドバイスを提供し、個々のニーズや好みに合わせた最適な衣服を提案してくれます。衣服は私たちの生活と密接に結びついており、AIはそれをより便利で楽しいものに変えてくれます。しかし、忘れてはならないのは、ファッションの本質は個性と表現です。AIとの共存は、自分自身を大切にし、自己表現を大胆に追求することを忘れないことです。')



Post.create(user_id: 2, image:File.open("./public/images/clothes1.png"), content: "マーブルチョコレートの衣服は、甘美なチョコレートの魅力を反映し、繊細な大理石模様が織りなす独特な美しさを表現しています。贅沢なテクスチャーと絶妙な色彩が融合し、魅惑的な衣装へと昇華。独自の美意識と調和のとれたデザインが、着る人の個性を引き立て、華やかな雰囲気を演出します。")
Post.create(user_id: 2, image:File.open("./public/images/clothes2.png"), content: "ピンクタイガーの衣服は、力強さと優雅さが融合したデザインです。タイガーの野性的なエッセンスを取り入れつつも、ピンクの柔らかな色合いが繊細さを加えます。大胆なグラフィックと独自のパターンが、個性的なスタイルを表現。強さと女性らしさが溢れ、自信と魅力を纏った一着となっています。")
Post.create(user_id: 2, image:File.open("./public/images/clothes3.png"), content: "ドラゴンの衣服は、神秘的なエネルギーと力強さを感じさせるデザインです。独特なシルエットと鱗のような質感が、ドラゴンの存在感を表現しています。ダークなカラーパレットとドラゴンのモチーフが融合し、ユニークな魅力を放つ一着となっています。勇気とパワーを纏い、まさに異世界から抜け出したようなスタイルを演出します。")
Post.create(user_id: 2, image:File.open("./public/images/clothes4.png"), content: "ライオンの衣服は、野性的な魅力と王者の風格が融合したデザインです。ライオンのメインとなる要素を独自のアプローチで再解釈し、大胆なプリントや刺繍で表現しています。堂々としたシルエットと豪華な装飾が、自信と気品を与えます。まさに野生の美しさと力強さを体現した一着となっています。")
Post.create(user_id: 3, image:File.open("./public/images/clothes5.png"), content: "「グレープ＆レモン」の衣服は、爽やかな果実の香りと鮮やかな色彩が溶け合うデザインです。グレープの優雅さとレモンの活気をモチーフに、柔らかな素材と鮮やかなプリントを組み合わせました。さわやかでエネルギッシュな印象を与える一方、洗練されたシルエットで女性らしさも引き立てます。まるで夏のフルーツを纏ったような、楽しさと魅力に満ちた一着です。")

Post.create(user_id: 3, image:File.open("./public/images/clothes6.png"), content: "「アップル」の衣服は、新鮮なりんごの魅力を表現したデザインです。豊かな色合いと独特の形状を取り入れ、シンプルでありながら個性的なアイテムを生み出しました。りんごのシンボルとしての健康と活力をイメージし、快適な素材と遊び心のあるディテールを組み合わせました。さわやかな鮮度とアピール力で、着る人に元気と魅力を与える一着です。")
Post.create(user_id: 3, image:File.open("./public/images/clothes7.png"), content: "「フレイム」の衣服は、炎のような情熱とエネルギーを込めたデザインです。燃え盛る炎の動きや輝きを表現し、ダイナミックなシルエットと炎の模様を取り入れました。熱い情熱と自己表現を象徴し、勇気と強さを感じさせるデザインアイテムです。鮮やかな色彩と刺激的なディテールで、着る人の内なる輝きを引き出します。")
Post.create(user_id: 3, image:File.open("./public/images/clothes8.png"), content: "「クリーム」の衣服は、柔らかな風合いと滑らかなテクスチャーが特徴です。クリームのような優雅さと上品さを表現し、女性の美しさを引き立てます。豊かな色調と繊細なデザインで、肌に溶け込むような優しい印象を与えます。洗練されたシルエットと贅沢な素材で、上品さと快適さを兼ね備えたアイテムです。まるでクリームを纏ったような魅力を放ちます。")
Post.create(user_id: 4, image:File.open("./public/images/clothes9.png"), content: "「ソーセージ」の衣服は、遊び心とユニークさが溢れるデザインです。色とりどりのソーセージの形状やパターンを取り入れ、楽しさとおしゃれさを融合させました。ユニークなシルエットや素材の組み合わせによって、個性的で魅力的なスタイルを演出します。ソーセージのエネルギッシュなイメージを取り入れつつも、快適さや着心地にもこだわりました。自由な発想と遊び心が詰まった衣服で、ファッションを楽しむ人々に新たな魅力を提案します。")
Post.create(user_id: 4, image:File.open("./public/images/clothes10.png"), content: "「氷」の衣服は、冷たさと清涼感を表現したデザインです。透明な素材やクリスタルの装飾を取り入れ、凍りついた美しさを演出します。シャープなシルエットと鮮やかな色彩で、氷のような冷たさと輝きを身にまといましょう。着る人に涼しさと高貴さを与える衣服で、洗練されたスタイルを完成させます。氷の美しい世界をファッションに昇華し、周囲を魅了する存在になりましょう。")

Post.create(user_id: 4, image:File.open("./public/images/clothes11.png"), content: "「宇宙と波」のテーマでデザインされた衣服は、宇宙の神秘と海の波の美しさを融合させた特別な存在です。流れるような柔らかな素材と、宇宙を彷彿させる輝く装飾が特徴であり、宇宙と海の神秘的なエネルギーを体現しています。色彩は深い青や紫をベースに、星や波のモチーフを織り交ぜたデザインが施されています。宇宙の広がりと海の奥深さを感じさせる衣服で、人々の心を引き込み、無限の可能性と自由を表現します。")
Post.create(user_id: 4, image:File.open("./public/images/clothes12.png"), content: "「カタストロフィ」というテーマでデザインされた衣服は、美と破壊の対比を表現した特異な存在です。構築と崩壊、力強さと脆さが共存するデザインが特徴であり、刺激的でドラマチックな雰囲気を醸し出しています。激しい色彩や不規則なシルエットが、混沌とした感情と不安定な世界の反映です。破壊された美しさや混沌が生み出す魅力を追求した衣服であり、人々に衝撃と驚きを与えながら、自己表現の可能性を広げます。")
Post.create(user_id: 5, image:File.open("./public/images/clothes13.png"), content: "「Twitter」というテーマでデザインされた衣服は、現代の情報社会とコミュニケーションの力を象徴しています。ツイートの文字列やアイコン、ハッシュタグをアートに昇華し、個性的でユニークなデザインを生み出しました。情報の流れや交流のダイナミズムを体現し、社会的なつながりと自己表現の融合を促進します。鮮やかなカラーパレットやグラフィックなパターンが、人々に魅力的な視覚体験と共感を提供します。Twitterのエッセンスを取り込んだこの衣服は、ファッションとデジタル世界の融合を象徴する存在です。")
Post.create(user_id: 5, image:File.open("./public/images/clothes14.png"), content: "「日本」というテーマでデザインされた衣服は、和の美学と現代の洗練が融合した究極の表現です。伝統的な柄や着物の要素をモダンに再解釈し、独自のデザインを生み出しました。日本の四季や風景、文化的な象徴をインスピレーションに取り入れ、日本の美を世界に発信します。緻密な技術と品質へのこだわりが実現した衣服は、日本の精神とクラフトマンシップを体現しています。日本の魅力とモダンなエッセンスが融合したこの衣服は、着る人に誇りと個性を与えます。")
Post.create(user_id: 5, image:File.open("./public/images/clothes15.png"), content: "「雲と雨」というテーマでデザインされた衣服は、自然の神秘と感性を映し出す作品です。雲の柔らかな質感や雨の優美な流れを表現し、独特の雰囲気と魅力を纏いました。柔らかな素材と繊細なディテールが調和し、着る人に優雅さと軽やかさをもたらします。雲のように自由な表現と、雨のような情熱的な感情を感じさせるこの衣服は、人々に夢とロマンを与えます。空気感と流れるような美しさが、個性的なスタイルを演出します。")

Post.create(user_id: 5, image:File.open("./public/images/clothes16.png"), content: "「ブロックとマインクラフト」というテーマでデザインされた衣服は、創造力と冒険心を融合させた作品です。マインクラフトの世界から着想を得て、ブロックの美しい幾何学的な形状や色彩を取り入れました。その結果、斬新で遊び心溢れるデザインが実現しました。ブロック同士が組み合わさり、新たな景色を作り出すように、この衣服は個性とスタイルを引き立てます。自由な発想と驚きに満ちたディテールが、着る人に刺激とクリエイティブなエネルギーをもたらします。マインクラフトの世界観を身にまとい、新たな冒険へと導く存在となるでしょう。")
Post.create(user_id: 6, image:File.open("./public/images/clothes17.png"), content: "「buzz-cut」というテーマでデザインされた衣服は、エッジの効いたスタイルと自己表現の象徴です。ショートヘアの清潔感とクールさを反映し、シンプルながらも強烈な印象を与えます。鮮やかな色彩やボールドなパターンが、個性と自信を引き立てます。さまざまなテクスチャーや切り替えによって、洗練されたシルエットが生まれ、動きやすさと快適さも追求しました。この衣服は、自由奔放な精神と大胆さを持つ人々に向けてデザインされ、彼らのスタイルと個性を際立たせます。バズカットのような短くて斬新なデザインが、ファッションの世界に刺激と新たなエネルギーをもたらします。")
Post.create(user_id: 6, image:File.open("./public/images/clothes18.png"), content: "「バナナ」というテーマでデザインされた衣服は、遊び心とポップさを取り入れた楽しいスタイルです。鮮やかな黄色や柔らかな曲線が特徴で、バナナの形やパターンがユニークなアクセントとなっています。フレッシュなイメージとエネルギーを与えるこの衣服は、明るさと陽気さを表現し、着る人の笑顔を引き出します。さわやかな素材や軽快なシルエットで、快適さと動きやすさも追求しました。この衣服は、自由な発想とカラフルな個性を持つ人々に向けてデザインされ、彼らのスタイルと楽しさを演出します。バナナの魅力をファッションに昇華し、新たな鮮やかな世界を創り出します。")
Post.create(user_id: 6, image:File.open("./public/images/clothes19.png"), content: "「グリーンキャット」というテーマでデザインされた衣服は、自然と個性の融合を表現した特別なコレクションです。緑の色合いと猫の柔らかな魅力が融合し、ユニークなパターンとディテールが特徴です。自然の美しさや生命力を感じさせる素材と、猫の優雅さや遊び心を反映したシルエットが調和し、穏やかなエネルギーを放ちます。また、猫の目や耳、しっぽのモチーフが随所にちりばめられ、遊び心と親しみを演出します。この衣服は、自然と動物への尊敬と愛情を表現し、着る人に優雅さと個性を与えます。グリーンキャットの世界に身を包んで、新たな魅力と自然の調和を楽しんでください。")
Post.create(user_id: 6, image:File.open("./public/images/clothes20.png"), content: "「オクトパス」というテーマでデザインされた衣服は、神秘と柔軟性の融合を表現した特別なコレクションです。蛸の優雅な動きや多彩な姿勢にインスパイアされ、独特なプリントやドレープを取り入れました。柔らかな素材と流れるようなシルエットが、蛸の魅力を再現し、身に纏った人に自由な表現と自信を与えます。また、テクスチャーやエンボス加工を活用し、蛸の触覚や肌触りを再現したディテールが際立ちます。この衣服は、神秘的な海の生物の美しさと力強さを象徴し、着る人にエレガントな魅力と自由な創造性をもたらします。蛸の魅力に包まれて、新たな海の世界への冒険を楽しんでください。")



Comment.create(user_id: 2, post_id: 20, content: '独創的で素晴らしいですね！')
Comment.create(user_id: 6, post_id: 7, content: 'どうやって着るの？')

Like.create(user_id: 2, post_id: 20)

Relationship.create(follower_id: 1, followed_id: 2)
Relationship.create(follower_id: 2, followed_id: 1)