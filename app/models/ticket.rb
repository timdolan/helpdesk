class Ticket < ActiveRecord::Base

  attr_accessible :title, :issue, :ticket_type, :priority, :urgency, :impact, :status, :resolution, :resolution_explanation, :location_id, :contact, :assigned_to

  belongs_to :user, :foreign_key => "contact"
  belongs_to :assigned_to_user, :foreign_key => "assigned_to", :class_name => "User"
  belongs_to :location

  default_scope :order => 'tickets.created_at DESC'

  TICKET_TYPE = ["incident", "request for service"]
  PRIORITY = ["high", "medium", "low"]
  URGENCY = ["high", "medium", "low"]
  IMPACT = ["high", "medium", "low"]
  STATUS = ["open", "re-open", "on hold", "in progress", "resolved", "closed"]
  RESOLUTION = ["none", "completed successfully", "no fault found", "see comments"]

  validates :title,             :presence => true
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



  def set_default_values
    self.contact = current_user unless !self.contact.nil?
    self.ticket_type = "request for service" unless !self.ticket_type.nil?
    self.priority = "medium" unless !self.priority.nil?
    self.urgency = "medium" unless !self.urgency.nil?
    self.impact = "medium" unless !self.impact.nil?
    self.status = "open" unless !self.status.nil?
    self.assigned_to = "1" unless !self.assigned_to.nil?
  end

end
