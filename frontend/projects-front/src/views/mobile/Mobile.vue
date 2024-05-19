<template>
    <header id="top-header">
        <div id="hd-flex">
            <a href="/mobile" class="pf-hd-center" id="hd-center" style="height:60px;">
                <div>IoT Robot Status</div>
            </a>
        </div>
    </header>
    <main id="socket-main">
        <div class="contents" id="socket-con">
            <h1>IoT機器操作アプリ</h1>
            <p id="socket-con-exp">ブラウザからIoT機器を操作するデモサイトです。</p>
        
            <div class="panel_item_wrap">
                <div id="demo-wrapper">
                    <div ref="demoImg" id="demo-img">
                        <div class="robot-eyes" id="left-eye" :style="eyesColor"></div>
                        <div class="robot-eyes" id="right-eye" :style="eyesColor"></div>
                        <img src="@/assets/images/robota.png" alt="" :style="shadowColor">
                        <div id="robot_photo" v-if="photoVisible">
                            <img src="@/assets/images/wolf.png" alt=""/>
                        </div>
                        <div id="robot_mp4" v-if="videoVisible">
                            <video :src="`${$baseURL}/videos/cat.mp4`" loop autoplay controls></video>
                        </div>
                    </div>
                </div>
                <div class="panel_item">
                    <div class="panel_item_content">
                        <div class="panel_item_ttl">
                            <h2>LEDカラーの変更</h2>
                        </div>
                        <div class="form_item">
                            <input
                                type="color"
                                class="preset_color"
                                v-model="selectedColor"
                                :class="{ 'pulse-animation': isAnimating }"
                                @animationend="resetAnimation"
                            >
                        </div>
                    </div>
                </div>
        
                <div class="panel_item">
                    <div class="panel_item_content">
                        <div class="panel_item_ttl">
                            <h2>画像をディスプレイに表示</h2>
                        </div>
                        <div class="flex_container_start upload_item">
                            <label class="toggle-switch">
                                <input type="checkbox" id="photo_switch" v-model="photoVisible" @click="videoReset">
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
        
                <div class="panel_item">
                    <div class="panel_item_content">
                        <div class="panel_item_ttl">
                            <h2>動画をディスプレイに表示</h2>
                        </div>
                        <div class="flex_container_start upload_item">
                            <label class="toggle-switch">
                                <input type="checkbox" id="mp4_switch" v-model="videoVisible" @click="photoReset">
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
        
                <div class="panel_item">
                    <div class="panel_item_content">
                        <div class="panel_item_ttl">
                            <h2>音楽ファイルの再生</h2>
                        </div>
                        <audio :src="`${$baseURL}/audios/electric_dream.mp3`"
                            controls
                            id="audio_player"
                            @play="startColorChange"
                            @pause="stopColorChange"
                            @ended="stopColorChange">
                        </audio>
                    </div>
                </div>
    
            </div>
            <h2>IoT機器からのデータ受信（DEMO）</h2>
            <div id="data"></div>
            <div id="graphs">
                <div v-for="(graph, index) in graphs" :key="graph.id" class="graph_item">
                    <p><strong>{{ graph.label }}</strong></p>
                    <div>
                        <canvas :id="'chart-' + index" class="ex_chart"></canvas>
                        <div class="graph_value"><p>現在の{{ graph.label }}</p><span>{{ graph.currentValue }} {{ graph.unit }}</span></div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer>
        <a href="/mobile" id="ft-center">
            <div>IoT Robot Status</div>
        </a>
        <p>- Anti Nihilism & Live Happy -</p>
        <ul class="follow-links">
        <li class="follow-link">
            <a href="https://twitter.com" target="_blank">
            <img src="@/assets/svg/twitter_w.svg" alt="" class="icon" />
            </a>
        </li>
        <li class="follow-link">
            <a href="https://ja-jp.facebook.com" target="_blank">
            <img src="@/assets/svg/facebook_w.svg" alt="" class="icon" />
            </a>
        </li>
        <li class="follow-link">
            <a href="https://www.instagram.com" target="_blank">
            <img src="@/assets/svg/instagram_w.svg" alt="" class="icon" />
            </a>
        </li>
        <li class="follow-link">
            <a href="https://line.me" target="_blank">
            <img src="@/assets/svg/line_w.svg" alt="" class="icon" />
            </a>
        </li>
        </ul>
        <small>(C) 2023 Liberal Earth All Rights Reserved.</small>
    </footer>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import '@/assets/stylesheets/mobile/mobile.css';
import Chart, { ChartConfiguration } from 'chart.js/auto';

export default defineComponent({
    name: 'AppMobile',
    data() {
        return {
            user: {
                photo: '/image/noimage.jpg',
                video: '',
                audio: ''
            },
            ledColor: '',
            chartData: [],
            intervalId: 0,
            isFixed: false,
            selectedColor: '#20b2aa',
            colors: ['#EF5658', '#3C76F7', '#8556EF', '#FF803C', '#FFDE2B', '#F0F3F8','#20b2aa', '#44D049', '#6ABBEF'],
            colorChangeInterval: null as any,
            currentColorIndex: 0,
            isAnimating: false,
            videoVisible: false,
            photoVisible: false,
            charts: [] as any[],
            intervals: [] as number[],
            graphs: [
                { id: 'battery', label: 'ロボットバッテリー残量', unit: '%', currentValue: 80, max: 100, min:0, constValue: 80, graphMax: 0, graphMin: 0 },
                { id: 'indoorTemperature', label: '室内温度', unit: '℃', currentValue: 25, max: 40, min:0, constValue: 25, graphMax: 0, graphMin: 0 },
                { id: 'outdoorTemperature', label: '外気温', unit: '℃', currentValue: 30, max: 40, min:0, constValue: 30, graphMax: 0, graphMin: 0 },
                { id: 'deviceCount', label: '接続デバイス数', unit: '台', currentValue: 5, max: 5, min:0, constValue: null, graphMax: 5, graphMin: 3 },
                { id: 'indoorHumidity', label: '室内湿度', unit: '%RH', currentValue: 62, max: 100, min:0, constValue: 62, graphMax: 0, graphMin: 0 },
                { id: 'indoorIlluminance', label: '室内照度', unit: 'LX', currentValue: 1232, max: 1500, min:0, constValue: 1232, graphMax: 0, graphMin: 0 },
                { id: 'indoorPressure', label: '室内気圧', unit: 'hPa', currentValue: 987, max: 1050, min:0, constValue: 987, graphMax: 0, graphMin: 0 },
                { id: 'indoorNoise', label: '室内ノイズ', unit: 'dB', currentValue: 95, max: 120, min:0, constValue: null, graphMax: 95, graphMin: 88 },
                { id: 'indoorCO2', label: '室内CO2濃度', unit: 'ppm', currentValue: 567, max: 800, min:0, constValue: 567, graphMax: 0, graphMin: 0 },
                { id: 'indoorAQI', label: '室内空気品質指数', unit: '', currentValue: 101, max: 500, min:0, constValue: null, graphMax: 101, graphMin: 98 },
                { id: 'discomfortIndex', label: '不快指数', unit: '', currentValue: 21, max: 100, min:0, constValue: null, graphMax: 21, graphMin: 23 },
                { id: 'heatstrokeRisk', label: '熱中症警戒度', unit: '', currentValue: 22, max: 100, min:0, constValue: null, graphMax: 22, graphMin: 23 },
            ],
        }
    },
    mounted() {
        this.setupGraphs();
    },
    beforeUnmount() {
        this.intervals.forEach(interval => clearInterval(interval));
    },
    computed: {
        eyesColor(): string {
            return `background:${this.selectedColor};`;
        },
        shadowColor(): string {
            return `box-shadow: 1px 1px 50px ${this.selectedColor};`;
        },
    },
    methods: {
        startColorChange() {
            this.colorChangeInterval = setInterval(() => {
                this.startScalePulse();
                this.selectedColor = this.colors[this.currentColorIndex];
                this.currentColorIndex++;
                if (this.currentColorIndex >= this.colors.length) {
                    this.currentColorIndex = 0;
                }
            }, 448);
        },
        stopColorChange() {
            if (this.colorChangeInterval) {
                clearInterval(this.colorChangeInterval);
                this.colorChangeInterval = null;
            }
        },
        resetImageSize() {
            if (this.$refs.imageRef) {
                (this.$refs.imageRef as HTMLElement).style.animation = 'none';
            }
        },
        startScalePulse() {
            this.isAnimating = true; // アニメーションを開始
        },
        resetAnimation() {
            this.isAnimating = false; // アニメーション終了時にリセット
        },
        videoReset() {
            this.videoVisible = false;
        },
        photoReset() {
            this.photoVisible = false;
        },
        generateDummyData(max: number, min: number) {
            return Math.random() * (max - min) + min;
        },
        setupGraphs() {
            this.graphs.forEach((graph, index) => {
                const canvas = document.getElementById(`chart-${index}`) as HTMLCanvasElement | null;
                if (canvas) {
                    const ctx = canvas.getContext('2d');
                    if (ctx === null) {
                        console.error('Failed to get rendering context for: ', canvas);
                        return;
                    }

                    const config: ChartConfiguration = {
                        type: 'line',
                        data: {
                            labels: Array.from({ length: 10 }, (_, k) => k + 1),
                            datasets: [{
                                pointRadius: 0,
                                borderWidth: 2,
                                label: graph.label,
                                data: Array(10).fill(graph.currentValue),
                                borderColor: 'lightseagreen',
                                xAxisID: 'x',
                                yAxisID: 'y'
                            }]
                        },
                        options: {
                            animation: false,
                            scales: {
                                x: {
                                    ticks: {
                                        display: false
                                    },
                                    grid: {
                                        display: false,
                                    },
                                    border: {
                                        display: false,
                                    },
                                },
                                y: {
                                    ticks: {
                                        display: true,
                                    },
                                    max: graph.max,
                                    min: graph.min,
                                    grid: {
                                        display: false,
                                    },
                                    border: {
                                        display: false,
                                    },
                                }
                            },
                            plugins: {
                                legend: {
                                    display: false
                                }
                            }
                        }
                    };

                    const chart = new Chart(ctx, config);
                    this.charts.push(chart);

                    const interval = setInterval(() => {
                        let newValue;
                        if (graph.constValue) {
                            newValue = graph.constValue;
                        } else {
                            newValue = this.generateDummyData(graph.graphMax, graph.graphMin);
                        }
                        chart.data.datasets[0].data.shift();
                        chart.data.datasets[0].data.push(newValue);
                        graph.currentValue = Math.round(newValue);
                        chart.update();
                    }, 1000);
                    this.intervals.push(interval);
                } else {
                    console.error('Canvas element not found');
                }
            });
        },
    },
});
</script>

<style scoped>
@keyframes scalePulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(0.5);
  }
}

.pulse-animation {
  animation: scalePulse 400ms ease-in-out;
}
</style>