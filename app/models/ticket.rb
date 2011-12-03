class Ticket < ActiveRecord::Base

  attr_accessible :title, :issue, :ticket_type, :priority, :urgency, :impact, :status, :resolution, :resolution_explanation, :location_id, :contact, :assigned_to

  belongs_to :user
  belongs_to :location

  validates :title,             :presence => true
  validates :issue,             :presence => true
  validates :ticket_type,       :presence => true,
                                :inclusion => { :in => Array["incident", "request for service"] }
  validates :priority,          :presence => true,
                                

end
