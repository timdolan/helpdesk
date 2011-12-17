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
  
  before_validation :set_default_values_if_necessary
  before_save :location_check
  
  
  def location_check
    if self.location_id_changed? && !self.new_record? 
      update_assigned_to
    end
  end
  
  def update_assigned_to
    self.assigned_to = self.location.user_id
  end
  
  def set_default_values_if_necessary
    if self.new_record?
      self.ticket_type = "request for service" if self.ticket_type.nil? or self.ticket_type == ""
      self.priority = "medium" if self.priority.nil? or self.priority == ""
      self.urgency = "medium" if self.urgency.nil? or self.urgency == ""
      self.impact = "medium" if self.impact.nil? or self.impact == ""
      self.status = "open" if self.status.nil? or self.status == ""
      self.assigned_to = self.location.user_id
    end
  end

end
