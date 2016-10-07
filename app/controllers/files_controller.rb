class FilesController < ApplicationController
  def privacy_terms
    respond_to do |format|
      format.pdf { send_file Rails.root.join 'public', 'documents', 'politica_de_privacidade.pdf' }
    end
  end
end
