class BabiesController < ApplicationController
  before_action :set_baby, only: [:show, :edit, :update, :destroy]

  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.all
  end

  # GET /babies/1
  # GET /babies/1.json
  def show
  end

  # GET /babies/new
  def new
    @baby = Baby.new
  end

  # GET /babies/1/edit
  def edit
  end

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

  # PATCH/PUT /babies/1
  # PATCH/PUT /babies/1.json
  def update
    respond_to do |format|
      if @baby.update(baby_params)
        format.html { redirect_to @baby, notice: 'Baby was successfully updated.' }
        format.json { render :show, status: :ok, location: @baby }
      else
        format.html { render :edit }
        format.json { render json: @baby.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /babies/1
  # DELETE /babies/1.json
  def destroy
    @baby.destroy
    respond_to do |format|
      format.html { redirect_to babies_url, notice: 'Baby was successfully destroyed.' }
      format.json { head :no_content }
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
