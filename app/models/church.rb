require 'geokit'

class Church < ActiveRecord::Base
  
  has_many :churches_patrons
  has_many :patrons, through: :churches_patrons
  has_many :churches_people, inverse_of: :church
  has_many :people, through: :churches_people
  has_many :church_counts
  belongs_to :diocese
  belongs_to :renew_region
  
  validates_presence_of :diocese
  validates_presence_of :name
  
  before_save :refresh_geolocation
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :growth_indicators, :growth_strategies, :patrons
  
  accepts_nested_attributes_for :churches_people, reject_if: :person_is_blank
  accepts_nested_attributes_for :church_counts
  
  def refresh_geolocation
   if postcode_changed? && postcode != nil
      geolocation = Geokit::Geocoders::GoogleGeocoder.geocode(postcode)
      if geolocation.success  
        self.lat = geolocation.lat
        self.lng = geolocation.lng
      end
    end  
  end
  
  def incumbent_name
    
  end
  
  def incumbent_age
    
  end
  
  def incumbent_start_year
    
  end
  
  def incumbent_start_month
    
  end
  
  def incumbent_churches_person
    all_incumbents = self.churches_people.select{|cp| cp.church_position == "incumbent"}
    all_incumbents.each do |i|
      if i.is_current?
        return i
      end
    end
    return nil
  end
  
  def incumbent
    if incumbent_churches_person.present?
       return incumbent_churches_person.person
    end
    return nil
  end
  
  def person_is_blank(attributes)
    this_person = attributes['person_attributes']
    this_person['first_name'].blank? && this_person['last_name'].blank? && this_person['full_name'].blank?
  end
  
  def self.create_or_update_from_row(row,headers)
    # NAME
    church_name = row[headers.index("Church")]
    if church_name.match(",")
      name,parish = church_name.split(",")
    else
      name = church_name
      parish = church_name
    end
    name = name.strip
    parish = parish.strip
    diocese_name = row[headers.index("Diocese")].strip
    
    # CHOOSE CHURCH
    
    church = Church.find_or_create_by(name: name, parish: parish, postcode: row[headers.index("Postcode")], diocese: Diocese.find_or_create_by(name: diocese_name) )
    

    
    # RENEW STATUS
    if headers.index("How would you describe the current state of your church?")
      status = row[headers.index("How would you describe the current state of your church?")]
      if status.present?
        if status.match(/secure/i)
          church.renew_status = "Secured"
        elsif status.match(/established/i)
          church.renew_status = "Established"
        elsif status.match(/getting there/i)
          church.renew_status = "Getting There"
        elsif status.match(/pioneer/i) 
          church.renew_status = "Pioneering"
        end
      end
    end
    # PROCESS INCUMBENT
    
    matching_person_headers = ["email","telephone"]
    non_matching_person_headers = [["First name","first_name"],["Last name","last_name"]]
    incumbent_attributes = {}
    matching_person_headers.each do |header|
      if headers.index{|i| i.downcase == header}.present?
        incumbent_attributes[header] = row[headers.index{|i| i.downcase == header}]
      end
    end
    # present for both sheets
    non_matching_person_headers.each do |sheet_header,db_header|
      if headers.index(sheet_header).present?
        incumbent_attributes[db_header] = row[headers.index(sheet_header)]
      end
    end
    # if he exists
    unless church.incumbent
      church.churches_people.build(church_position: "incumbent", person: Person.new(incumbent_attributes))
    end
    incumbent = church.incumbent
    incumbent.assign_attributes(incumbent_attributes)
    
    
    # PROCESS STAFFING
    [["male_clergy","Ordained men"],["female_clergy","Ordained women"],["male_laity","Lay men"],["female_laity","Lay women"]].each do |field_name,sheet_header|
      if headers.index(sheet_header).present?
        church.send("number_of_#{field_name}_employed=",row[headers.index(sheet_header)])
      end
    end
    if headers.index("Diocese funded staff").present?  
      church.diocesan_funded_staff = row[headers.index("Diocese funded staff")]
    end
    
    # PROCESS CHURCH COUNTS
    [
      ["No on Electoral Roll (as reported to APCM 2014)","Electoral Roll",2014,3],
      ["2015 Electoral Roll","Electoral Roll",2015,3],
      ["2016 Electoral Roll","Electoral Roll",2016,3],
      ["2014 Weekly Attendance","Average Weekly Attendance",2014,3],
      ["2015 Weekly Attendance","Average Weekly Attendance",2015,3]
    ].each do |column_header,count_type,year,month|
      if headers.index(column_header).present?
        if church.church_counts.find{|cc| cc.count_type == count_type && cc.count_year == year}
          church_count = church.church_counts.find{|cc| cc.count_type == count_type && cc.count_year == year}
        else
          church_count = church.church_counts.build(count_type: count_type,count_year: year, count_month: month)
        end
        church_count.count_number = row[headers.index(column_header)]
      end
    end


    
    # PROCESS HOUSE OF BISHOPS
    
    ["Passed","In the process of passing","Passed by November 2017","PCC Unconvinced","PCC Unconcerned"].each do |s|
      if headers.index(s).present?
        if row[headers.index(s)] == "Y"
          church.house_of_bishops_declaration = s
        end
      end
    end
    if headers.index("House of Bishops other").present?
      church.house_of_bishops_declaration_other = row[header.index("House of Bishops other")]
    end

    
    # SAVE 
    church.save
    
    
    # tagging processes that require a saved record
    
    # PATRONAGE
    if headers.index("If you are affiliated to the CofE, do you have any of the following evangelical Patrons?")
      church.patron_list = row[headers.index("If you are affiliated to the CofE, do you have any of the following evangelical Patrons?")]
    end
    
    # AFFILIATIONS
    if headers.index("Is your church affiliated with any of the following?")
      church.affiliation_list = row[headers.index("Is your church affiliated with any of the following?")]
    end
    
    # GROWTH INDICATORS
    
    growth_indicators = []
    ["New plant","New congregation","20% + increase","Converts","No Growth"].each do |a|
      if headers.index(a).present?
        if row[headers.index(a)] == "Y"
          growth_indicators << a
        end
      end
    end
    church.growth_indicator_list = growth_indicators

    
    # GROWTH STRATEGIES
    
    growth_strategies = []
    ["Evangelistic Courses","Home Groups","1 to 1 Bible Study","Discipleship Study","Special courses","Support for Individuals"].each do |a|
      if headers.index(a).present?
        if row[headers.index(a)] == "Y"
          growth_strategies << a
        end
      end
    end
    church.growth_strategy_list = growth_strategies
    
    church.save
    
    # PROCESS INCUMBENT AFFILIATIONS
    
    affiliations = []
    ["CofE","Crosslinks","New Wine","AMiE","Free Church of England","Other"].each do |a|
      if headers.index(a).present?
        if row[headers.index(a)] == "Y"
          affiliations << a
        end
      end
    end
    incumbent.affiliation_list = affiliations
    
    # PROCESS INCUMBENT Beliefs
    beliefs = []
    [["NC","Nicene Creed"],["39 Art.","39 Articles"],["CEEC","Church of England Evangelical Council"],["Gafcon","Jerusalem Statement"],["Reform"],["Withheld"],["Other"]].each do |b|
      if headers.index(b[0]).present?
        if row[headers.index(b[0])] == "Y"
          beliefs << b[0]
        end
      end
    end
    
    incumbent.belief_list = beliefs
    incumbent.save
    
    
  end
end
