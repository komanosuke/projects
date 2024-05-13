<template>
    <!-- <div id="flash">{{ flashMessage }}</div> -->
    <div id="cxxsew-contents">
        <div class="table-name">
            <div v-if="modelName == undefined">
                <h1>指定したモデルは存在しません。</h1>
            </div>
            <div v-else>
                <h1>{{ modelName }} 一覧</h1>
                <div v-if="models">
                    <div class="btn"><a href="/cxxsew/article_cats/new">新規作成</a></div>
                    <p>{{ modelName }}数合計: {{ Object.keys(models).length }}</p>
                    <p>←データ列が多い場合は横スクロール→</p>
                    <div class="table-wrapper" id="scroll-table">
                        <div class="tr">
                            <div class="th scroll-th check">
                                <input type="checkbox" id="check-all" @change="toggleAll" :checked="allChecked">
                            </div>
                            <div class="th scroll-th id">ID</div>
                            <div class="th scroll-th name">NAME</div>
                        </div>
                        <div class="tr" v-for="model in models" :key="model.id">
                            <div class="td scroll-td check">
                                <input type="checkbox" :id="'check-' + model.id" class="delete-check" v-model="selectedIds" :value="model.id">
                            </div>
                            <div class="td scroll-td id">{{ model.id }}</div>
                            <div class="td scroll-td name">{{ model.name }}</div>
                        </div>
                    </div>
                </div>
                <div v-else>
                    <p>{{ modelName }}が投稿されていません。</p>
                    <div class="btn"><a href="/article_cats/new">新規作成</a></div>
                </div>

                <button class="btn submit-btn" id="delete-btn" @click="deleteSelected">削除</button>
                <div class="btn" id="submit-btn"><a href="/cxxsew/admin">管理画面トップへ</a></div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

interface Settings {
    [key: string]: string;
}

interface Model {
    id: number;
    name: string;
}

const setting: Settings = {
    works: '商品',
    work_cats: '商品カテゴリー',
    articles: '記事',
    article_cats: '記事カテゴリー',
    news: 'ニュース',
    news_cats: 'ニュースカテゴリー',
};

export default defineComponent({
    name: 'CxxsewAdminView',
    data() {
        return {
            models: [] as Model[],
            modelName: '' as string,
            selectedIds: [] as number[],
        };
    },
    props: {
        model: {
            type: String,
            required: true,
        },
    },
    created() {
        this.modelName = setting[this.model];
        this.fetchModels();
    },
    computed: {
        allChecked: {
            get(): boolean {
                return this.models.length > 0 && this.selectedIds.length === this.models.length;
            },
            set(value: boolean): void {
                this.selectedIds = value ? this.models.map(model => model.id) : [];
            },
        },
    },
    methods: {
        async fetchModels() {
            try {
                const response = await this.$api.get<Model[]>(`/${this.model}`);
                this.models = response.data;
                console.log(this.models);
            } catch (error) {
                console.error(error);
            }
        },
        toggleAll(event: Event) {
            const target = event.target as HTMLInputElement;
            this.allChecked = target.checked;
        },
        deleteSelected() {
            console.log('Deleting items with IDs:', this.selectedIds);
            // 削除のAPIリクエストを実行するコードをここに記述
        },
    },
});
</script>
