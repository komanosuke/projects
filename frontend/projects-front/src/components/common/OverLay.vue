<template>
    <div id="overlay" v-if="overlay">
        <div class="loader"></div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'OverLay',
    data() {
        return {
            overlay: false,
        };
    },
    props: {
        overlayVisible: Boolean,
    },
    mounted() {
        this.overlay = this.overlayVisible;
    },
});
</script>
    