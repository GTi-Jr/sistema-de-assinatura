Turnout.configure do |config|
  config.app_root = Rails.root.to_s
  config.named_maintenance_file_paths = { app: 'tmp/app.yml', server: '/tmp/server.yml' }
  config.maintenance_pages_path = Rails.root.join('app', 'views', 'maintenance').to_s
  config.default_maintenance_page = Turnout::MaintenancePage::Erb
  config.default_reason = 'O site está passando por reformulações! Volte em breve.'
  config.default_allowed_paths = ['^/admin/']
  config.default_response_code = 418
  config.default_retry_after = 3600
end
