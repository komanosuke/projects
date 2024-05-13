<template>
<body id="cost-body">
    <main>
        <div class="contents" id="cost-con">
            <!-- <div id="page-top" @click="smoothScrollTo('#cost-body')"><span>↑</span></div> -->
            
            <h1>生涯収支の概算アプリ</h1>
            <!-- <p>https://fukupon.jp/a/17032323</p> -->
            <p>生涯収入と生涯支出から老後資金の過不足が確認できます。</p>
            <div id="cost-result">
                <div>計算結果</div>
                <div><span class="lifeincome">{{ totalLifeIncome.toLocaleString() }}</span>円（生涯収入）</div>
                <div> - </div>
                <div><span id="cost">{{ totalLifeCost.toLocaleString() }}</span>円（生涯支出）</div>
                <div> = </div>
                <div id="shortage" v-if="difference >= 0"><span id="difference">{{ difference.toLocaleString() }}</span>円 の余剰</div>
                <div id="shortage" v-else><span id="difference">{{ difference.toLocaleString() }}</span>円 の不足</div>
                <!-- <p class="ex">不足する場合、退職金や年金、貯蓄などで補填が必要。</p> -->
            </div>
            <!--
            <p>以下に年金と老後資産の合計を入力してください。</p>
            <div>年金<input type="number" id="pension_set" class="set_input" value="20000000" min="0" max="100000000">円</div>
            -->
            <div class="cost-section">
                <h2>生涯収入の設定</h2>
                <table class="cost-table">
                    <tr>
                        <th>年代</th>
                        <th>平均年収</th>
                        <th>年数</th>
                        <th>合計</th>
                    </tr>
                    <tr>
                        <th>20代</th>
                        <td><input type="number" class="gene_cost_input" v-model="income20s">円/年</td>
                        <td> × <input type="number" v-model="year20s" class="year_setting" max="10"> = </td>
                        <td><span class="gene_cost_year">{{ (income20s * year20s).toLocaleString() }}</span> 円</td>
                    </tr>
                    <tr>
                        <th>30代</th>
                        <td><input type="number" class="gene_cost_input" v-model="income30s">円/年</td>
                        <td> × <input type="number" v-model="year30s" class="year_setting" max="10"> = </td>
                        <td><span class="gene_cost_year">{{ (income30s * year30s).toLocaleString() }}</span> 円</td>
                    </tr>
                    <tr>
                        <th>40代</th>
                        <td><input type="number" class="gene_cost_input" v-model="income40s">円/年</td>
                        <td> × <input type="number" v-model="year40s" class="year_setting" max="10"> = </td>
                        <td><span class="gene_cost_year">{{ (income40s * year40s).toLocaleString() }}</span> 円</td>
                    </tr>
                    <tr>
                        <th>50代</th>
                        <td><input type="number" class="gene_cost_input" v-model="income50s">円/年</td>
                        <td> × <input type="number" v-model="year50s" class="year_setting" max="10"> = </td>
                        <td><span class="gene_cost_year">{{ (income50s * year50s).toLocaleString() }}</span> 円</td> 
                    </tr>
                    <tr>
                        <th>60代</th>
                        <td><input type="number" class="gene_cost_input" v-model="income60s">円/年</td>
                        <td> × <input type="number" v-model="year60s" class="year_setting" max="10"> = </td>
                        <td><span class="gene_cost_year">{{ (income60s * year60s).toLocaleString() }}</span> 円</td>
                    </tr>
                    <tr>
                        <th>合計</th>
                        <td></td>
                        <td></td>
                        <td><span id="my_year_total">{{ totalLifeIncome.toLocaleString() }}</span> 円</td>
                    </tr>
                </table>
                <div class="decided-cost">生涯収入 ＝ <span class="lifeincome">{{ totalLifeIncome.toLocaleString() }}</span>円</div>
            </div>
    
            <!-- <div id="simulate-box">
                <h2>ボタンを押してオプションを選択</h2>
                <button id="default_mode" class="btn cost-btn">リセット</button>
                <button id="marry_mode" class="btn cost-btn">結婚</button>
                <button id="child_mode" class="btn cost-btn">子ども</button>
                <button id="house_mode" class="btn cost-btn">住宅購入</button>
                <button id="car_mode" class="btn cost-btn">車購入</button>
                
                <button id="care_mode" class="btn cost-btn">親の介護</button>
                
            </div> -->
            
            <div class="cost-section" id="all-cost-section">
                <!-- <p id="mode">
                    <span class="option">結婚</span>
                    <span class="option">子ども</span>
                    <span class="option">住宅</span>
                    <span class="option">車</span>
                    <span class="option">介護</span>
                </p> -->
                <h2>生涯支出の計算</h2>
                <p>表の中の「▶︎設定」をクリックすると、設定ができます。</p>
                <table class="cost-table">
                    <tr>
                        <th>項目</th>
                        <th>平均的な例</th>
                        <th>オリジナル設定</th>
                    </tr>
                    <tr id="income">
                        <td>生涯収入</td>
                        <td><span class="income_ex">{{ averageTotalLifeIncome.toLocaleString() }}</span> 円</td>
                        <td><span class="income_ex" id="income-td">{{ totalLifeIncome.toLocaleString() }}</span> 円</td>
                    </tr>
                    <tr>
                        <td>22～64歳の平均生活費</td>
                        <td><span class="cost">{{ averageLivingCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ middleLifeCost.toLocaleString() }}</span>円</div><span @click="showLifecostPopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr>
                        <td>結婚関連費用</td>   
                        <td><span class="cost">{{ averageMarriageCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ marriageCost.toLocaleString() }}</span>円</div><span @click="showMarriagePopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr class="option_cost">
                        <td>子供の学習費</td>
                        <td><span class="cost">{{ averageChildCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ childCost.toLocaleString() }}</span>円</div><span @click="showChildPopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr class="option_cost">
                        <td>マイホーム</td>
                        <td><span class="cost">{{ averageHouseCost.toLocaleString() }}</span> 円</td>
                    <td><div class="my_cost_wrapper"><span class="my_cost">{{ houseCost.toLocaleString() }}</span>円</div><span @click="showHousePopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr class="option_cost">
                        <td>マイカー</td>
                        <td><span class="cost">{{ averageCarCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ carCost.toLocaleString() }}</span>円</div><span @click="showCarPopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr class="option_cost">
                        <td>生命保険</td>
                        <td><span class="cost">{{ averageInsuranceCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ insuranceCost.toLocaleString() }}</span>円</div><span @click="showInsurancePopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr>
                        <td>老後の平均生活費</td>
                        <td><span class="cost">{{ averageRetirementCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ retirementCost.toLocaleString() }}</span>円</div><span @click="showRetirePopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr>
                        <td>税金等</td>
                        <td><span class="cost">{{ averageTaxCost.toLocaleString() }}</span> 円</td>
                        <td><div class="my_cost_wrapper"><span class="my_cost">{{ tax.toLocaleString() }}</span>円</div><span @click="showTaxPopup" class="cost-setting">▶︎設定</span></td>
                    </tr>
                    <tr id="lifecost_total">
                        <td>支出合計</td>
                        <td><span id="total">{{ averageLifeCost.toLocaleString() }}</span> 円</td>
                        <td><span id="my_total">{{ totalLifeCost.toLocaleString() }}</span> 円</td>
                    </tr>
                </table>
                <p class="ex">※ 平均的な例を見ても {{ (-(averageTotalLifeIncome - averageLifeCost)).toLocaleString() }} 円の不足 → 貯蓄、年金、退職金で賄えるように調整が必要</p>
                <div class="decided-cost">生涯支出 ＝ <span class="red">{{ totalLifeCost.toLocaleString() }}</span>円</div>
            </div>
    
            

            <div v-if="isPopupVisible" class="popup" @click="closePopup">
                <div class="popup-content" @click.stop>
                    <div class="close-button" @click="closePopup"></div>
                    <div class="cost-section" v-if="isLifecostVisible">
                        <h2 id="evid1">22～64歳の平均生活費</h2>
                        <p>設定すると、1か月の生活費と1年の生活費が算出されます。</p>
                        <p>22～64歳の平均生活費は統計上、単身世帯は年191万円、2人以上の世帯は年372万円※2です。仮に30歳で結婚すると「191万円×8年＋372万円×35年＝1億4548万円」が必要になります。
            
                            単身世帯	2人以上
                            年191万円	年372万円
                            ただし、単身世帯は都市部では物価が高いために月15万円程度では生活できませんし、逆に2人以上の世帯は節約次第で減額できます。
                            
                            ※2 総務省（2016年）「家計調査」</p>

                        <p><strong>- 住居費、子ども費、自動車費、保険費について -<br></strong><span class="ex-span"></span>色の部分をここで設定する場合は、全体での設定を0円にしてください。<br>逆に、全体で設定する場合はここでの<span class="ex-span"></span>色の部分を0円にしてください。</p>

                        <div class="cost-table-wrapper">
                            <p>①固定費</p>
                            <table class="cost-table">
                                <tr>
                                    <th>項目</th>
                                    <th>費用（月）</th>
                                    <th>費用（年）</th>
                                </tr>
                                <tr class="option_cost">
                                    <td>住宅費（家賃、住宅ローン、管理費など）</td>
                                    <td><input type="number" class="basic_month" v-model="housingCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ housingCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>水道光熱費（水道代、電気代、ガス代）</td>
                                    <td><input type="number" class="basic_month" v-model="utilityCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ utilityCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>通信料（インターネット接続料、携帯電話代、固定電話代など）</td>
                                    <td><input type="number" class="basic_month" v-model="communicationCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ communicationCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr class="option_cost">
                                    <td>保険料（生命保険、医療保険、学資保険、個人年金など）</td>
                                    <td><input type="number" class="basic_month" v-model="insuranceCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ insuranceCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>交通費（通勤や通学のための定期代など）</td>
                                    <td><input type="number" class="basic_month" v-model="transportationCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ transportationCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>小遣い（夫、妻、子どもの小遣い）</td>
                                    <td><input type="number" class="basic_month" v-model="pocketMoneyMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ pocketMoneyYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>その他（サブスク、新聞購読料、ウォーターサーバーレンタル料、ジム代など）</td>
                                    <td><input type="number" class="basic_month" v-model="otherCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ otherCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr class="option_cost">
                                    <td>車両費（車のローン、駐車場代、車検代、自動車税、自動車保険料など）</td>
                                    <td><input type="number" class="basic_month" v-model="carCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ carCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr class="option_cost">
                                    <td>保育料、学費（保育園・幼稚園の費用、小学校・中学校・高校・大学の費用など）</td>
                                    <td><input type="number" class="basic_month" v-model="educationCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ educationCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr class="option_cost">
                                    <td>習い事（子どもの塾や習い事の月謝、自分や家族のカルチャースクール等の月謝など）</td>
                                    <td><input type="number" class="basic_month" v-model="lessonsMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ lessonsYear.toLocaleString() }}</span> 円</td>
                                </tr>
                            </table>
                        </div>

                        <div class="cost-table-wrapper">
                            <p>②変動費</p>
                            <table class="cost-table">
                                <tr>
                                    <th>項目</th>
                                    <th>費用</th>
                                    <th>費用（年）</th>
                                </tr>
                                <tr>
                                    <td>食費（食料品代、外食代など）</td>
                                    <td><input type="number" class="basic_month" v-model="foodCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ foodCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>日用品費（掃除道具や、ティッシュペーパーなどの日用品、消耗品代など）</td>
                                    <td><input type="number" class="basic_month" v-model="supppliesCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ supppliesCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>医療費（医薬品代、通院費、入院費など）</td>
                                    <td><input type="number" class="basic_month" v-model="medicalCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ medicalCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>被服費（洋服などの購入、クリーニング代など）</td>
                                    <td><input type="number" class="basic_month" v-model="clothesCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ clothesCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>美容費（化粧品購入や美容院代など）</td>
                                    <td><input type="number" class="basic_month" v-model="beautyCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ beautyCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>交際費（飲み会代、お祝いのプレゼント代、ご祝儀など）</td>
                                    <td><input type="number" class="basic_month" v-model="entertainmentCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ entertainmentCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>娯楽費（書籍の購入や映画鑑賞など）</td>
                                    <td><input type="number" class="basic_month" v-model="amusementCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ amusementCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>雑費（その他の少額な出費）</td>
                                    <td><input type="number" class="basic_month" v-model="miscCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ miscCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr>
                                    <td>特別費（家電購入代や旅行費など）</td>
                                    <td><input type="number" class="basic_month" v-model="specialCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ specialCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                                <tr class="option_cost">
                                    <td>子ども費（教材代、文具や書籍代、部活動や習い事の雑費など）</td>
                                    <td><input type="number" class="basic_month" v-model="childCostMonth" value="">円</td>
                                    <td><span class="basic_cost">{{ childCostYear.toLocaleString() }}</span> 円</td>
                                </tr>
                            </table>
                        </div>
                        <p>１ヶ月の生活費（①固定費+②変動費） ＝ <span id="basic_total_month">{{ totalMonthCost.toLocaleString() }}</span> 円</p>
                        <p>１年の生活費 ＝ <strong class="red">{{ totalYearCost.toLocaleString() }}</strong> 円</p>
                    </div>

                    <div class="cost-section" v-if="isMarriageVisible">
                        <h2 id="evid2">結婚関連費用</h2>
                        <p>結婚関連費用は婚約から新婚旅行までで<strong class="red">総額513万円</strong>※3でした。内訳は「婚約56万円、結婚指輪24万円、結婚式360万円、新婚旅行73万円」です。
            
                            ただし、ご祝儀が平均200万円、親からの援助金も平均200万円得られるために、個人差はありますが、結果的に収支はそこまで生涯に影響しません。さらに結婚式や披露宴をしない人たちも増えており、必須の支出ではありません。
                            
                            ※3 リクルートブライダル総研「結婚トレンド調査2016」</p>
                        
                        <div>結婚費用<input type="number" id="marriage_set" v-model="marriageCost" class="set_input" value="5130000" min="0" max="10000000">円</div>
                    </div>
                    
                    <div class="cost-section" v-if="isChildVisible">
                        <h2 id="evid3">子供の学習費</h2>
                        <p>小学校から大学まですべて公立は986万円、すべて私立は2519万円※4、最も割合が多い幼稚園から高校までが公立、大学から私立に自宅通学したケースを想定すると、<strong class="red">平均1275万円</strong>になります。</p>
                        <table>
                            <tr>
                                <th>対象</th>
                                <th>公立</th>
                                <th>私立</th>
                            </tr>
                            <tr>
                                <th>幼稚園</th>
                                <td>67万円</td>
                                <td>149万円</td>
                            </tr>
                            <tr>
                                <th>小学校</th>
                                <td>193万円</td>
                                <td>922万円</td>
                            </tr>
                            <tr>
                                <th>中学校</th>
                                <td>143万円</td>
                                <td>402万円</td>
                            </tr>
                            <tr>
                                <th>高校</th>
                                <td>123万円</td>
                                <td>209万円</td>
                            </tr>
                            <tr>
                                <th>大学</th>
                                <td>458万円</td>
                                <td>747万円</td>
                            </tr>
                        </table>	
                        <p>ただ、現在は保育園に通わせる世帯も多く、その場合は所得と自治体によって、保育料に月数万円の差が出ます。
                            
                            大学も公立と私立の違いだけではなく、文系と理系、自宅通学と1人暮らし、4年制と医学部や薬学部、留学などもあるため、子供の学習費は平均値から乖離しやすい項目です。
                            
                            ※4 文部科学省（2014年）「子供の学習費調査」</p>
                        
                        <div>一人当たり<input type="number" id="child_set" v-model="childCost" class="set_input" value="12750000" min="0" max="100000000">円</div>
                        <p></p>
                    </div>
            
                    <div class="cost-section" v-if="isHouseVisible">
                        <h2 id="evid4">マイホーム</h2>
                        <p>マイホームは「購入と賃貸、新築と中古、一戸建てとマンション、土地ありと土地なし、注文と建売、都市部と地方」などと多数の選択肢があり、個人差と地域差が発生しやすいです。
            
                            統計上の最安値は全国の中古戸建てで2252万円※5、最高値は首都圏のマンションで4851万円ですが、35年ローンを組むことで利息の1000～2000万円が増えます。また、賃貸でも総額は6000万円程度を見ておきたいです。
                        </p>
                        <table>
                            <tr>
                                <th>対象</th>
                                <th>全国</th>
                                <th>首都圏</th>
                            </tr>
                            <tr>
                                <th>注文住宅</th>
                                <td>3274万円</td>
                                <td>3586万円</td>
                            </tr>
                            <tr>
                                <th>注文住宅＋土地</th>
                                <td><strong class="red">3945万円</strong></td>
                                <td>4667万円</td>
                            </tr>
                            <tr>
                                <th>建売住宅</th>
                                <td>3287万円</td>
                                <td>3538万円</td>
                            </tr>
                            <tr>
                                <th>マンション</th>
                                <td>4271万円</td>
                                <td>4851万円</td>
                            </tr>
                            <tr>
                                <th>中古戸建て</th>
                                <td>2252万円</td>
                                <td>2753万円</td>
                            </tr>
                            <tr>
                                <th>中古マンション</th>
                                <td>2635万円</td>
                                <td>2906万円</td>
                            </tr>
                        </table>
                        <p>※5 住宅金融支援機構（2015年）「フラット35利用者調査」</p>
                        
                        <div>総額<input type="number" id="house_set" v-model="houseCost" class="set_input" value="39450000" min="0" max="10000000000">円</div>
                        <p></p>
                    </div>
            
                    <div class="cost-section" v-if="isCarVisible">
                        <h2 id="evid5">マイカー</h2>
                        <p>マイカーは都市部では不要な人も多いですが、地方では生活必需品であり、また、子供がいるとなおさら必要です。維持費の中に車検代も含まれていますが、ガソリン代と駐車場代は別途必要です。
            
                            例えば、30～70歳の40年間で8年置きに買い替えると、1回あたり新車が220万円、8年間の維持費が80万円となり、5回分で<strong class="red">1500万円</strong>※6がかかります。
                            ただし、新車も100万未満から1000万円以上とピンきりですし、駐車場代なども個人差が大きいです。また、平均的には自家用車を40年間乗ったときの支出額は2564万円になります。
                            ※6 日本自動車工業会「2015年度 乗用車市場動向調査」</p>
                        
                        <div>総額<input type="number" id="car_set" v-model="carCost" class="set_input" value="15000000" min="0" max="100000000">円</div>
                        <p></p>
                    </div>
            
                    <div class="cost-section" v-if="isInsuranceVisible">
                        <h2 id="evid6">生命保険</h2>
                        <p>生命保険は男性が月平均20083円、女性が月平均15166円※7です。仮に男性が25～64歳に加入すると「月平均20083円×40年＝<strong class="red">964万円</strong>」になります。
            
                            現状では生命保険や医療保険は1人暮らしのときは、月2000～3000円の都民共済や県民共済の掛け捨てでも構いません。ただ、子供が生まれると万が一のために月1万～2万円に増やす人が多いです。
                            
                            ちなみに病気やケガによる入院費は「1日1万円×30日＝30万円」が一般的です。ただし、この数字には高齢者が多く含まれており、20～40代であれば入院する割合が低いため、確率的には考慮しない人も多いです。
                            ※7 生命保険文化センター「平成25年度 生活保障に関する調査」</p>
                        
                        <div>生命保険総額<input type="number" id="insurance_set" v-model="insuranceCost" class="set_input" value="9640000" min="0" max="100000000">円</div>
                        <p></p>
                    </div>
            
                    <div class="cost-section" v-if="isRetireVisible">
                        <h2 id="evid7">老後の平均生活費</h2>
                        <p>単身世帯は年180万円、2人以上の世帯は年280万円※8かかります。仮に65～84歳を夫婦で暮らすと「288万円×20年＝<strong class="red">5760万円</strong>」が必要です。
            
                            老後の平均生活費は特に重要です。人生の3大支出は教育資金、住宅資金、老後資金であり、子供やマイホームを持たない選択肢はありますが、65～84歳の生活費は削減できません。
                            
                            ※8 総務省統計局（2016年）「家計調査」</p>
                        
                        <div>老後費総額<input type="number" id="after_retire_set" v-model="retirementCost" class="set_input" value="57600000" min="0" max="100000000">円</div>
                        <p></p>
                    </div>
            
                    <div class="cost-section" v-if="isTaxVisible">
                        <h2 id="evid8">税金等</h2>
                        <p>総収入から差し引く税金等の設定（%）を入力してください。</p>
                        <div>生涯年収の<input type="number" id="tax_set" v-model="taxRate" class="set_input" value="20" min="0" max="100">%</div>
                        <p>日本人の平均年収441万円を基準にして、所得税、住民税、社会保険料で合計<strong class="red">20％</strong>に初期値を設定しています。今後は消費税や年金保険料の負担増は免れないため、25％に設定することもあります。</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
<LoginFooter/>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import LoginFooter from '../../components/layouts/login/LoginFooter.vue';
import '@/assets/stylesheets/money/money.css';

export default defineComponent({
    name: 'AppMoney',
    components: {
        LoginFooter,
    },
    data() {
        return {
            isPopupVisible: false,
            isLifecostVisible: false,
            isMarriageVisible: false,
            isChildVisible: false,
            isHouseVisible: false,
            isCarVisible: false,
            isInsuranceVisible: false,
            isRetireVisible: false,
            isTaxVisible: false,
            income20s: 3000000 as number,
            income30s: 4000000 as number,
            income40s: 5000000 as number,
            income50s: 6000000 as number,
            income60s: 2000000 as number,
            incomeRetire: 0 as number,

            year20s: 8 as number,
            year30s: 10 as number,
            year40s: 10 as number,
            year50s: 10 as number,
            year60s: 5 as number,
            
            housingCostMonth: 0 as number,
            utilityCostMonth: 0 as number,
            communicationCostMonth: 0 as number,
            insuranceCostMonth: 0 as number,
            transportationCostMonth: 0 as number,
            pocketMoneyMonth: 0 as number,
            otherCostMonth: 0 as number,
            carCostMonth: 0 as number,
            educationCostMonth: 0 as number,
            lessonsMonth: 0 as number,
            
            foodCostMonth: 0 as number,
            supppliesCostMonth: 0 as number,
            medicalCostMonth: 0 as number,
            clothesCostMonth: 0 as number,
            beautyCostMonth: 0 as number,
            entertainmentCostMonth: 0 as number,
            amusementCostMonth: 0 as number,
            miscCostMonth: 0 as number,
            specialCostMonth: 0 as number,
            childCostMonth: 0 as number,
            
            averageTotalLifeIncome: 270000000 as number,
            averageLivingCost: 145480000 as number,
            averageMarriageCost: 5130000 as number,
            averageChildCost: 12750000 as number,
            averageHouseCost: 39450000 as number,
            averageCarCost: 15000000 as number,
            averageInsuranceCost: 9640000 as number,
            averageRetirementCost: 57600000 as number,
            averageTaxCost: 0 as number,
            averageLifeCost: 0 as number,
            
            marriageCost: 0 as number,
            childCost: 0 as number,
            houseCost: 0 as number,
            carCost: 0 as number,
            insuranceCost: 0 as number,
            retirementCost: 0 as number,
            taxRate: 20 as number,
        }
    },
    watch: {
        isPopupVisible(newValue) {
            if (newValue) {
                document.body.classList.add('body-no-scroll');
            } else {
                document.body.classList.remove('body-no-scroll');
            }
        }
    },
    mounted() {
        this.marriageCost = this.averageMarriageCost;
        this.childCost = this.averageChildCost;
        this.houseCost = this.averageHouseCost;
        this.carCost = this.averageCarCost;
        this.insuranceCost = this.averageInsuranceCost;
        this.retirementCost = this.averageRetirementCost;
        this.averageTaxCost = this.averageTotalLifeIncome * (this.taxRate/100);
        this.averageLifeCost = this.averageLivingCost + this.marriageCost + this.childCost + this.houseCost + this.carCost + this.insuranceCost + this.retirementCost + this.averageTaxCost;
    },
    computed: {
        totalLifeIncome(): number {
            return this.income20s * this.year20s + this.income30s * this.year30s + this.income40s * this.year40s + this.income50s * this.year50s + this.income60s * this.year60s + this.incomeRetire;
        },
        totalYearIncome(): number {
            return Math.round((this.income20s + this.income30s + this.income40s + this.income50s + this.income60s) / 5);
        },

        housingCostYear(): number {
            return this.housingCostMonth * 12;
        },
        utilityCostYear(): number {
            return this.utilityCostMonth * 12;  
        },
        communicationCostYear(): number {
            return this.communicationCostMonth * 12;
        },
        insuranceCostYear(): number {
            return this.insuranceCostMonth * 12;
        },
        transportationCostYear(): number {
            return this.transportationCostMonth * 12;
        },
        pocketMoneyYear(): number {
            return this.pocketMoneyMonth * 12;
        },
        otherCostYear(): number {
            return this.otherCostMonth * 12;
        },
        carCostYear(): number {
            return this.carCostMonth * 12;
        },
        educationCostYear(): number {
            return this.educationCostMonth * 12;
        },
        lessonsYear(): number {
            return this.lessonsMonth * 12;
        },
        foodCostYear(): number {
            return this.foodCostMonth * 12;
        },
        supppliesCostYear(): number {
            return this.supppliesCostMonth * 12;
        },
        medicalCostYear(): number {
            return this.medicalCostMonth * 12;
        },
        clothesCostYear(): number {
            return this.clothesCostMonth * 12;
        },
        beautyCostYear(): number {
            return this.beautyCostMonth * 12;
        },
        entertainmentCostYear(): number {
            return this.entertainmentCostMonth * 12;
        },
        amusementCostYear(): number {
            return this.amusementCostMonth * 12;
        },
        miscCostYear(): number {
            return this.miscCostMonth * 12;
        },
        specialCostYear(): number {
            return this.specialCostMonth * 12;
        },
        childCostYear(): number {
            return this.childCostMonth * 12;
        },

        totalMonthCost(): number {
            return this.housingCostMonth + this.utilityCostMonth + this.communicationCostMonth +
            this.insuranceCostMonth + this.transportationCostMonth + this.pocketMoneyMonth +
            this.otherCostMonth + this.carCostMonth + this.educationCostMonth + this.lessonsMonth +
            this.foodCostMonth + this.supppliesCostMonth + this.medicalCostMonth + this.clothesCostMonth +
            this.beautyCostMonth + this.entertainmentCostMonth + this.amusementCostMonth + this.miscCostMonth +
            this.specialCostMonth + this.childCostMonth;
        },
        totalYearCost(): number {
            return this.totalMonthCost * 12;  
        },

        middleLifeCost(): number {
            return this.totalYearCost * 43; // 22-64歳の年数
        },
        totalLifeCost(): number {
            return this.middleLifeCost + this.marriageCost + this.childCost + this.houseCost +
            this.carCost + this.insuranceCost + this.retirementCost;
        },
        tax(): number {
            return this.totalLifeIncome * (this.taxRate / 100);
        },
        difference(): number {
            return this.totalLifeIncome - this.totalLifeCost;
        }
    },
    methods: {
        // ターゲットエレメントまでスムーズスクロールを実行するメソッド
        smoothScrollTo(selector: string) {
            // ターゲットとなるエレメントを取得
            const element = document.querySelector(selector) as HTMLElement;
            if (!element) return;  // 要素が見つからない場合は処理を中断

            // ヘッダーの高さ。実際のヘッダーの高さに合わせて調整
            const headerOffset = 110;
            const elementPosition = element.getBoundingClientRect().top;
            const offsetPosition = elementPosition + window.scrollY - headerOffset;

            // スムーズスクロールを実行
            window.scrollTo({
                top: offsetPosition,
                behavior: 'smooth'
            });
        },
        openPopup() {
            this.isPopupVisible = true;
        },
        showLifecostPopup() {
            this.openPopup();
            this.isLifecostVisible = true;
        },
        showMarriagePopup() {
            this.openPopup();
            this.isMarriageVisible = true;
        },
        showChildPopup() {
            this.openPopup();
            this.isChildVisible = true;
        },
        showHousePopup() {
            this.openPopup();
            this.isHouseVisible = true;
        },
        showCarPopup() {
            this.openPopup();
            this.isCarVisible = true;
        },
        showInsurancePopup() {
            this.openPopup();
            this.isInsuranceVisible = true;
        },
        showRetirePopup() {
            this.openPopup();
            this.isRetireVisible = true;
        },
        showTaxPopup() {
            this.openPopup();
            this.isTaxVisible = true;
        },
        closePopup() {
            this.isPopupVisible = false;
            this.isLifecostVisible = false;
            this.isMarriageVisible = false;
            this.isChildVisible = false;
            this.isHouseVisible = false;
            this.isCarVisible = false;
            this.isInsuranceVisible = false;
            this.isRetireVisible = false;
            this.isTaxVisible = false;
        },
    },
});
</script>