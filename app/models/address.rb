class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :street
  validates_presence_of :zipcode
  validates_presence_of :number
  validates_presence_of :city
  validates_presence_of :state
end
