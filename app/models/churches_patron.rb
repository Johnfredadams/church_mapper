class ChurchesPatron < ActiveRecord::Base
  belongs_to :church
  belongs_to :patron
end
