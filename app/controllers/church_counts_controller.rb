class ChurchCountsController < ApplicationController
  before_action :set_church_count, only: [:show, :edit, :update, :destroy]

  # GET /church_counts
  # GET /church_counts.json
  def index
    @church_counts = ChurchCount.all
  end

  # GET /church_counts/1
  # GET /church_counts/1.json
  def show
  end

  # GET /church_counts/new
  def new
    @church_count = ChurchCount.new
  end

  # GET /church_counts/1/edit
  def edit
  end

  # POST /church_counts
  # POST /church_counts.json
  def create
    @church_count = ChurchCount.new(church_count_params)

    respond_to do |format|
      if @church_count.save
        format.html { redirect_to @church_count, notice: 'Church count was successfully created.' }
        format.json { render :show, status: :created, location: @church_count }
      else
        format.html { render :new }
        format.json { render json: @church_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /church_counts/1
  # PATCH/PUT /church_counts/1.json
  def update
    respond_to do |format|
      if @church_count.update(church_count_params)
        format.html { redirect_to @church_count, notice: 'Church count was successfully updated.' }
        format.json { render :show, status: :ok, location: @church_count }
      else
        format.html { render :edit }
        format.json { render json: @church_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /church_counts/1
  # DELETE /church_counts/1.json
  def destroy
    @church_count.destroy
    respond_to do |format|
      format.html { redirect_to church_counts_url, notice: 'Church count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church_count
      @church_count = ChurchCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def church_count_params
      params.require(:church_count).permit(:count_type, :count_number, :count_year, :count_month, :count_day, :count_approx, :church_id)
    end
end
