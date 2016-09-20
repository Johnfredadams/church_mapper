class ChurchesPeopleController < ApplicationController
  before_action :set_churches_person, only: [:show, :edit, :update, :destroy]

  # GET /churches_people
  # GET /churches_people.json
  def index
    @churches_people = ChurchesPerson.all
  end

  # GET /churches_people/1
  # GET /churches_people/1.json
  def show
  end

  # GET /churches_people/new
  def new
    @churches_person = ChurchesPerson.new
  end

  # GET /churches_people/1/edit
  def edit
  end

  # POST /churches_people
  # POST /churches_people.json
  def create
    @churches_person = ChurchesPerson.new(churches_person_params)

    respond_to do |format|
      if @churches_person.save
        format.html { redirect_to @churches_person, notice: 'Churches person was successfully created.' }
        format.json { render :show, status: :created, location: @churches_person }
      else
        format.html { render :new }
        format.json { render json: @churches_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /churches_people/1
  # PATCH/PUT /churches_people/1.json
  def update
    respond_to do |format|
      if @churches_person.update(churches_person_params)
        format.html { redirect_to @churches_person, notice: 'Churches person was successfully updated.' }
        format.json { render :show, status: :ok, location: @churches_person }
      else
        format.html { render :edit }
        format.json { render json: @churches_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /churches_people/1
  # DELETE /churches_people/1.json
  def destroy
    @churches_person.destroy
    respond_to do |format|
      format.html { redirect_to churches_people_url, notice: 'Churches person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_churches_person
      @churches_person = ChurchesPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def churches_person_params
      params.require(:churches_person).permit(:church_id, :person_id, :start_date_year, :start_date_month, :start_date_day, :end_date_year, :end_date_month, :end_date_day)
    end
end
