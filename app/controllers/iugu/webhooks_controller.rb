class Iugu::WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  # Controller para retorno da API do Iugu. Algumas mudanças no sistema deles
  # dispara eventos em nosso sistema, mandando alguns parâmetros.
  #
  # https://iugu.com/referencias/gatilhos
  def webhook
    Iugu::WebhookHandler.process(params[:event], params[:data]) if params[:key] == ENV['IUGU_WEBHOOK_KEY']
    render nothing: true
  end
end

