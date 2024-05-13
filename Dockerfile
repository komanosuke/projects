FROM ruby:3.1.3

ENV RAILS_ENV=production
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y apt-utils build-essential libpq-dev default-mysql-client && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn

# アプリケーションディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundler を使って依存関係をインストール
RUN bundle install --jobs 4 --retry 3

# アプリケーションのソースをコピー
COPY . .

# Railsサーバーを起動
CMD ["bundle", "exec", "puma", "-C", "/app/config/puma.rb"]
# CMD ["bundle", "exec", "unicorn", "-c", "/app/config/unicorn.rb"]

# ポート3000を公開
EXPOSE 3000