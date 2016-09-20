class DiocesesController < ApplicationController
  before_action :set_diocese, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in

  # GET /dioceses
  # GET /dioceses.json
  def index
    @dioceses = Diocese.all
  end
  
  def map
    @diocese = Diocese.where("lower(name) = ?",params[:diocese_name]).first
    @churches = @diocese.churches
  end

  # GET /dioceses/1
  # GET /dioceses/1.json
  def show
  end

  # GET /dioceses/new
  def new
    @diocese = Diocese.new
  end

  # GET /dioceses/1/edit
  def edit
  end

  # POST /dioceses
  # POST /dioceses.json
  def create
    @diocese = Diocese.new(diocese_params)

    respond_to do |format|
      if @diocese.save
        format.html { redirect_to @diocese, notice: 'Diocese was successfully created.' }
        format.json { render :show, status: :created, location: @diocese }
      else
        format.html { render :new }
        format.json { render json: @diocese.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dioceses/1
  # PATCH/PUT /dioceses/1.json
  def update
    respond_to do |format|
      if @diocese.update(diocese_params)
        format.html { redirect_to @diocese, notice: 'Diocese was successfully updated.' }
        format.json { render :show, status: :ok, location: @diocese }
      else
        format.html { render :edit }
        format.json { render json: @diocese.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dioceses/1
  # DELETE /dioceses/1.json
  def destroy
    @diocese.destroy
    respond_to do |format|
      format.html { redirect_to dioceses_url, notice: 'Diocese was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diocese
      @diocese = Diocese.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diocese_params
      params.require(:diocese).permit(:name, :province)
    end
end
