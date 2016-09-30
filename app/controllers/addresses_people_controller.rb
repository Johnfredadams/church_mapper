class AddressesPeopleController < ApplicationController
  before_action :set_addresses_person, only: [:show, :edit, :update, :destroy]

  # GET /addresses_people
  # GET /addresses_people.json
  def index
    @addresses_people = AddressesPerson.all
  end

  # GET /addresses_people/1
  # GET /addresses_people/1.json
  def show
  end

  # GET /addresses_people/new
  def new
    @addresses_person = AddressesPerson.new
  end

  # GET /addresses_people/1/edit
  def edit
  end

  # POST /addresses_people
  # POST /addresses_people.json
  def create
    @addresses_person = AddressesPerson.new(addresses_person_params)

    respond_to do |format|
      if @addresses_person.save
        format.html { redirect_to @addresses_person, notice: 'Addresses person was successfully created.' }
        format.json { render :show, status: :created, location: @addresses_person }
      else
        format.html { render :new }
        format.json { render json: @addresses_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses_people/1
  # PATCH/PUT /addresses_people/1.json
  def update
    respond_to do |format|
      if @addresses_person.update(addresses_person_params)
        format.html { redirect_to @addresses_person, notice: 'Addresses person was successfully updated.' }
        format.json { render :show, status: :ok, location: @addresses_person }
      else
        format.html { render :edit }
        format.json { render json: @addresses_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses_people/1
  # DELETE /addresses_people/1.json
  def destroy
    @addresses_person.destroy
    respond_to do |format|
      format.html { redirect_to addresses_people_url, notice: 'Addresses person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addresses_person
      @addresses_person = AddressesPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def addresses_person_params
      params.require(:addresses_person).permit(:address_id, :person_id)
    end
end
