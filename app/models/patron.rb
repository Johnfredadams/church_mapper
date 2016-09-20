class Patron < ActiveRecord::Base
  has_many :churches_patrons
end
