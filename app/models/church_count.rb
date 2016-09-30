class ChurchCount < ActiveRecord::Base
  belongs_to :church
  
  validates_presence_of :church
  validates_presence_of :count_type
  validates :count_year, presence: true, uniqueness: {scope: [:count_type,:church_id,:age_group] }
end
