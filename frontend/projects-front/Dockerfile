# Node.js のバージョンを指定
FROM node:16.13.1

# 作業ディレクトリの設定
WORKDIR /app

# 環境変数ファイルをコピー
COPY .env /app/.env
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json

# npm を使って依存関係をインストール
RUN npm install

# ホストのファイルをコンテナにコピー
COPY . /app

# 8080ポートを公開
EXPOSE 8080

# Vue.js アプリケーションを起動
CMD ["npm", "run", "serve"]
