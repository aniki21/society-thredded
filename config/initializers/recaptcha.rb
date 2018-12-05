if Rails.env.development?
  Recaptcha.configure do |config|
    config.site_key  = Settings.recaptcha_site_key
    config.secret_key = Settings.recaptcha_secret_key
    # Uncomment the following line if you are using a proxy server:
    # config.proxy = 'http://myproxy.com.au:8080'
  end
end
