class Person < ActiveRecord::Base
  has_many :churches_people
  has_many :churches, through: :churches_people
end
