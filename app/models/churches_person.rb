class ChurchesPerson < ActiveRecord::Base
  belongs_to :church
  belongs_to :person
end
