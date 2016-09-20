require 'geokit'

class Church < ActiveRecord::Base
  
  has_many :churches_patrons
  has_many :patrons, through: :churches_patrons
  has_many :churches_people
  has_many :people, through: :churches_people
  belongs_to :diocese
  belongs_to :renew_region
  
  validates_presence_of :diocese
  validates_presence_of :name
  
  before_save :refresh_geolocation

  
  def refresh_geolocation
   if postcode_changed? && postcode != nil
      geolocation = Geokit::Geocoders::GoogleGeocoder.geocode(postcode)
      if geolocation.success  
        self.lat = geolocation.lat
        self.lng = geolocation.lng
      end
    end  
  end
end
