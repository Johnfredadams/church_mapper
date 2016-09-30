class AddressesPerson < ActiveRecord::Base
  belongs_to :address
  belongs_to :person
end
