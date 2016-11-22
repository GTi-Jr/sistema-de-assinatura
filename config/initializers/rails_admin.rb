RailsAdmin.config do |config|
  config.main_app_name = ["Caixa da Cegonha", "admin"]
  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end

  config.current_user_method(&:current_admin)
  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # Usar nomes do I18N
  config.models do
    edit do
      fields do
        help do
          model = self.abstract_model.model_name.underscore
          field = self.name
          model_lookup = "admin.help.#{model}.#{field}".to_sym
          field_lookup = "admin.help.#{field}".to_sym
          I18n.t model_lookup, :help => help, :default => [field_lookup, help]
        end
      end
    end
  end

  # Menu lateral
  config.navigation_static_links = {
    'Google' => 'http://www.google.com'
  }
end
