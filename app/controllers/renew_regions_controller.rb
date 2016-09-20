class RenewRegionsController < ApplicationController
  before_action :set_renew_region, only: [:show, :edit, :update, :destroy]

  # GET /renew_regions
  # GET /renew_regions.json
  def index
    @renew_regions = RenewRegion.all
  end

  # GET /renew_regions/1
  # GET /renew_regions/1.json
  def show
  end

  # GET /renew_regions/new
  def new
    @renew_region = RenewRegion.new
  end

  # GET /renew_regions/1/edit
  def edit
  end

  # POST /renew_regions
  # POST /renew_regions.json
  def create
    @renew_region = RenewRegion.new(renew_region_params)

    respond_to do |format|
      if @renew_region.save
        format.html { redirect_to @renew_region, notice: 'Renew region was successfully created.' }
        format.json { render :show, status: :created, location: @renew_region }
      else
        format.html { render :new }
        format.json { render json: @renew_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /renew_regions/1
  # PATCH/PUT /renew_regions/1.json
  def update
    respond_to do |format|
      if @renew_region.update(renew_region_params)
        format.html { redirect_to @renew_region, notice: 'Renew region was successfully updated.' }
        format.json { render :show, status: :ok, location: @renew_region }
      else
        format.html { render :edit }
        format.json { render json: @renew_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /renew_regions/1
  # DELETE /renew_regions/1.json
  def destroy
    @renew_region.destroy
    respond_to do |format|
      format.html { redirect_to renew_regions_url, notice: 'Renew region was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_renew_region
      @renew_region = RenewRegion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def renew_region_params
      params.require(:renew_region).permit(:name)
    end
end
