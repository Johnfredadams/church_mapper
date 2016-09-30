class Address < ActiveRecord::Base
  has_many :addresses_people, dependent: :destroy
  has_many :people, through: :addresses_people
end
