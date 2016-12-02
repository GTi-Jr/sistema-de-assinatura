 #The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
Rails.application.config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
Rails.application.config.i18n.default_locale = :pt
