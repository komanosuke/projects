# MySQL 8.0 を Debian ベースで使用
FROM mysql:8.0-debian

# 必要なパッケージのインストールとクリーンアップ
RUN apt-get update && \
    apt-get install -y apt-utils locales && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ロケール設定
ENV LC_ALL ja_JP.UTF-8

# MySQL設定ファイルを追加
COPY charset.cnf /etc/mysql/conf.d/charset.cnf