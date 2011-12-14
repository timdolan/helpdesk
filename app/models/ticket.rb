class Ticket < ActiveRecord::Base

  attr_accessible :title, :issue, :ticket_type, :priority, :urgency, :impact, :status, :resolution, :resolution_explanation, :location_id, :contact, :assigned_to

  belongs_to :user, :foreign_key => "contact"
  belongs_to :assigned_to_user, :foreign_key => "assigned_to", :class_name => "User"
  belongs_to :location
  has_many :comments

  default_scope :order => 'tickets.created_at DESC'

  TICKET_TYPE = ["incident", "request for service"]
  PRIORITY = ["high", "medium", "low"]
  URGENCY = ["high", "medium", "low"]
  IMPACT = ["high", "medium", "low"]
  STATUS = ["open", "re-open", "on hold", "in progress", "resolved", "closed"]
  RESOLUTION = ["none", "completed successfully", "no fault found", "see comments"]

  validates :title,             :presence => true, 
                                :length => { :within => 1..254 }
  validates :issue,             :presence => true
  validates :ticket_type,       :presence => true,
                                :inclusion => { :in => TICKET_TYPE }
  validates :priority,          :presence => true,
                                :inclusion => { :in => PRIORITY }
  validates :urgency,           :presence => true,
                                :inclusion => { :in => URGENCY }
  validates :impact,            :presence => true,
                                :inclusion => { :in => IMPACT }
  validates :status,            :presence => true,
                                :inclusion => { :in => STATUS }
  validates :location_id,       :presence => true
  

  def set_default_values
    ticket_type = "request for service" if ticket_type.nil? or ticket_type == ""
    priority = "medium" if priority.nil? or priority == ""
    urgency = "medium" if urgency.nil? or urgency == ""
    impact = "medium" if impact.nil? or impact == ""
    status = "open" if status.nil? or status == ""
    assigned_to = "1" if assigned_to.nil? or assigned_to == ""
  end

end
