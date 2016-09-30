class Person < ActiveRecord::Base
  has_many :churches_people
  has_many :churches, through: :churches_people
  has_many :addresses_people, dependent: :destroy
  has_many :addresses, through: :addresses_people
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :beliefs, :affiliations
  
  attr_encrypted :email, key: :encryptor_key
  attr_encrypted :phone, key: :encryptor_key
  
  def encryptor_key
    ENV["ENCRYPTION_KEY"]
  end
end
