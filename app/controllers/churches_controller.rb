require 'google/apis/sheets_v4'

class ChurchesController < ApplicationController
  before_action :set_church, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in

  # GET /churches
  # GET /churches.json
  def index
    @churches = Church.all
  end
  
  def map
    @churches = Church.where(diocese_id: params[:diocese_id])
  end

  # GET /churches/1
  # GET /churches/1.json
  def show
  end

  # GET /churches/new
  def new
    @church = Church.new
  end

  # GET /churches/1/edit
  def edit
    if @church.incumbent_churches_person.blank?
      @church.churches_people.build(church_position: "incumbent").build_person
    end
  end
  
  def import
    # method for importing values from a fixed file format on google drive
    service = Google::Apis::SheetsV4::SheetsService.new
    service.authorization = authorization
    spreadsheet_id = params[:spreadsheet_id]
    range = params[:sheet_name] + '!A:CG'
    response = service.get_spreadsheet_values(spreadsheet_id,range)
    values = response.values
    headers = values.shift
    header_template = ["Ref","CS","PP","ReN 15","ReN 16","Data 15","Data 16","Address 1","Address 2","Address 3","For approximately how long has your church had strong bible-teaching leadership?","","No of churches","No on Electoral Roll (as reported to APCM 2014)","No on Electoral Roll (as reported to APCM 2015)","Average Weekly Attendance (October 2014)","How many children (0-10) were in your 'worshipping community' at the end of 2014","How many young people (11-17) were in your 'worshipping community' at the end of 2014","","How many young adults (18-30) were in your 'worshipping community' at the end of 2014","How many adults (31-69) were in your 'worshipping community' at the end of 2014","","How many adults (70+) were in your 'worshipping community' at the end of 2014","Total Worshipping Community","Is there evidence of your church growing significantly over the past 10 years?","If you or your church have pioneered a healthy local Anglican church since Sept 2013 - please give the name of the church, its relationship with the diocese and the name of the vicar below.","What proportion of centrally-funded clergy costs does the church cover with its contribution to the parish share?","Are you currently training a curate?","How many other staff are funded by the church (or by sources other than the diocese)?","How many women in your church are 'set-aside' for complementarian Bible teaching ministry?","If you are in the CofE - Has your PCC passed the old Resolutions A, B or C in the past five years?","If you are in the CofE - Is your PCC likely to pass a resolution under the new Women Bishops legislation?","What would the likely reaction be of the PCC/leadership to some form of 'good disagreement' over same-sex relationships?","","","","","","","",""]
    values.each do |row|

      Church.create_or_update_from_row(row,headers)
    end
    redirect_to churches_url
  end

  # POST /churches
  # POST /churches.json
  def create
    @church = Church.new(church_params)

    respond_to do |format|
      if @church.save
        format.html { redirect_to @church, notice: 'Church was successfully created.' }
        format.json { render :show, status: :created, location: @church }
      else
        format.html { render :new }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /churches/1
  # PATCH/PUT /churches/1.json
  def update
    respond_to do |format|
      if @church.update(church_params)
        format.html { redirect_to @church, notice: 'Church was successfully updated.' }
        format.json { render :show, status: :ok, location: @church }
      else
        format.html { render :edit }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /churches/1
  # DELETE /churches/1.json
  def destroy
    @church.destroy
    respond_to do |format|
      format.html { redirect_to churches_url, notice: 'Church was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def church_params
      params.require(:church).permit(:name, :parish, :locality, :diocese_id, :renew_region_id, :postcode, :renew_status, :description, :vacant, :start_month, :start_year, :incumbent_name, :incumbent_age, :incumbent_age_approx, :incumbent_start_month, :incumbent_start_year, :average_weekly_attendance, :number_of_male_clergy_employed, :number_of_male_laity_employed,:number_of_female_clergy_employed, :number_of_female_laity_employed, :diocesan_funded_staff, :diocesan_funded_curates, :funding, :cofe_status, :network, :house_of_bishops_declaration, :house_of_bishops_declaration_other, :diocesan_help_for_growth, :diocesan_help_for_growth_comment, :permission_for_mapping, :permission_for_sharing, church_counts_attributes: [:id, :count_type, :count_number, :count_year, :count_month, :count_day, :count_approx, :age_group ], churches_people_attributes: [:id, :start_date_year, :start_date_month, :start_date_day, person_attributes: [:id, :full_name, :first_name, :last_name, :age, :age_approx, :email, :title, :gender, :phone, :renew_member_since]], growth_indicator_list: [], growth_strategy_list: [] )
    end
    
    def authorization
      Google::Auth::DefaultCredentials.make_creds(json_key_io: StringIO.new(ENV["GOOGLE_SERVICE_ACCOUNT_CREDENTIALS"]), scope: ['https://www.googleapis.com/auth/spreadsheets'])
    end
end
