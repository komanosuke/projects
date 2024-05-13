const { defineConfig } = require('@vue/cli-service')
const webpack = require('webpack');
module.exports = defineConfig({
  devServer: {
    allowedHosts: 'all',
  },
  transpileDependencies: true,
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({ 
        __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: JSON.stringify(true),
      }),
    ],
  },
});