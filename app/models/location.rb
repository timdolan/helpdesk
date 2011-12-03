class Location < ActiveRecord::Base

  attr_accessible :name, :address, :user_id

  belongs_to :user
  has_many :users, :foreign_key => "location_id"
  has_many :tickets, :foreign_key => "location_id"


  validates :name,        :presence => true
  validates :address,     :presence => true

end
