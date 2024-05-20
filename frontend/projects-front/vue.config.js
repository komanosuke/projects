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

// const { defineConfig } = require('@vue/cli-service');
// const webpack = require('webpack');
// const fs = require('fs');
// const path = require('path');

// module.exports = defineConfig({
//   devServer: {
//     allowedHosts: 'all',
//     server: {
//       type: 'https',
//       options: {
//         key: fs.readFileSync(path.resolve(__dirname, 'certs/privkey.pem')),
//         cert: fs.readFileSync(path.resolve(__dirname, 'certs/fullchain.pem')),
//       },
//     },
//     hot: false,  // ホットモジュールリプレースメントを無効にする
//     liveReload: false,  // ライブリロードを無効にする
//     proxy: {
//       '/ws': {
//         target: 'http://localhost:8080',
//         ws: true,
//         changeOrigin: true,
//         secure: false,
//         pathRewrite: { '^/ws': '' },
//       },
//     },
//     client: {
//       webSocketURL: 'wss://app.liberal-earth.com/ws',
//     },
//   },
//   transpileDependencies: true,
//   configureWebpack: {
//     plugins: [
//       new webpack.DefinePlugin({
//         __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: JSON.stringify(true),
//       }),
//     ],
//   },
// });
