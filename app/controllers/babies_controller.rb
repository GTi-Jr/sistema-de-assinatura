class BabiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_baby, only: [:destroy]

  # POST /babies
  # POST /babies.json
  def create
    @user=User.find(params[:user_id])
    @baby = @user.babies.build(baby_params)

    respond_to do |format|
      if @baby.save
        format.html { redirect_to @baby, notice: 'Baby was successfully created.' }
        format.json { render :show, status: :created, location: @baby }
      else
        format.html { render :new }
        format.json { render json: @baby.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /babies/1
  # DELETE /babies/1.json
  def destroy
    if @baby.belongs_to? current_user
      @baby.destroy
      redirect_to :back, notice: "#{@baby.name} foi apagado."
    else
      redirect_to :back, alert: 'Erro ao apagar bebê. Tente novamente'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_baby
      @baby = Baby.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def baby_params
      params.require(:baby).permit(:name, :born, :months, :birthdate,:user_id)
    end
end
