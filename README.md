# projects ポートフォリオアプリケーション
* 以前ポートフォリオとして作成したwebアプリ群の一部をvue対応したものです。
* URL: https://liberal-earth-frontend.vercel.app （現在停止しております）
* URL: https://awnchan.vercel.app　（ポートフォリオ稼働中）
* アカウントを作成しなくても、ヘッダーの「log in」ボタンからログインページに移動後ゲストログインができます。メールアドレスの登録が必要ですが、アカウントの新規作成もできます。

# 使用技術

* Ruby 3.1.3
* Ruby on Rails 7.0.8.1
* Puma
* Nginx

## データベース
* MySQL

## コンテナ
* docker-composeでrails, vue, nginx, mysqlを管理（ポートフォリオのため簡略化しています。モダンな構成のアプリケーションはportfolioリポジトリをご参照ください。）

## デプロイ
* EC2

# サービス概要

## ECショップ
* 架空のファッションブランドのECショップです。カート機能やお問い合わせメール機能、管理者による商品や記事の編集機能が実装されています。
<img width="1440" alt="cxxsew" src="https://github.com/komanosuke/projects/assets/54266017/fe95e74a-e57c-41da-b82b-6ece074494fc">

## SNS
* 架空のファッションデザイナー向けSNSです。デザインした服をアピールするために利用できます。投稿機能、投稿編集機能、いいね機能、コメント機能、フォロー機能、画像投稿機能、無限スクロールページネーションなどが実装されています。
<img width="1440" alt="sns" src="https://github.com/komanosuke/projects/assets/54266017/6997fe19-1d25-4a91-8d62-3b5a10fcba8e">


## IoT機器と通信できるアプリ
* IoT機器と接続していないので単なるデモですが、IoT機器のカラー変更などの操作や、機器から送られるデータの視覚化ができるwebアプリです。
<img width="1440" alt="mobile" src="https://github.com/komanosuke/projects/assets/54266017/73fb0a47-d18b-4187-be5a-a07df56eada1">
