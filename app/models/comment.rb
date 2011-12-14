class Comment < ActiveRecord::Base

  attr_accessible :body, :status, :ticket_id, :user_id

  belongs_to :ticket

  default_scope :order => 'comments.created_at DESC'


end
