Rails.application.configure do
  # Middleware for error notifications
  # config.middleware.use ExceptionNotification::Rack,
  #   email: {
  #     email_prefix: "[Error] ",
  #     sender_address: %{"notifier" <notifier@example.com>},
  #     exception_recipients: %w{admin@example.com}
  #   }

  # Forcing all access to the app over SSL
  config.force_ssl = true

  # Setting up the mailer for error notifications
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    enable_starttls_auto: true,
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: :plain,
  }

  # # キャッシュの設定例
  config.cache_classes = true
  config.eager_load = true
  config.public_file_server.enabled = true
  
  # # 認証トークンの期限切れを無効化する設定例
  # config.active_record.disable_implicit_join_references = true
  
  # # ログの出力例
  # config.log_level = :info
  # config.log_tags = [:request_id]
  
  # # メモリ使用量の最適化設定例
  # config.middleware.use Rack::Deflater
  
  # # リバースプロキシの設定例
  # config.action_dispatch.trusted_proxies = ['192.168.1.0/16', '10.0.0.0/8']

  # # Redis cache store configuration
  # config.cache_store = :redis_cache_store, {
  #   url: ENV['REDIS_URL'],
  #   namespace: 'myapp_cache',
  #   expires_in: 1.day
  # }
  config.cache_store = :memory_store

  # Adjustments for asset hosting and default URL options for full SSL setup
  # config.action_controller.asset_host = 'https://portfolio-box.jp'
  # config.action_controller.default_url_options = { protocol: 'https' }
  # config.action_mailer.default_url_options = { protocol: 'https', host:'portfolio-box.jp'}
  # config.action_controller.forgery_protection_origin_check = false

  # Base secret key configuration
  config.secret_key_base = ENV['SECRET_KEY_BASE']
end