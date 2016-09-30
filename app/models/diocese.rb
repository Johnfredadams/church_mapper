class Diocese < ActiveRecord::Base
  has_many :churches
  
  validates :name, presence: true, uniqueness: true, case_sensitive: false
end
