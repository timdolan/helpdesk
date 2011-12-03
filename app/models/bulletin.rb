class Bulletin < ActiveRecord::Base

  attr_accessible :title, :bulletin, :current, :public

  belongs_to :user

  default_scope :order => 'bulletins.created_at DESC'
  
  validates :title,           :presence => true
  validates :bulletin,        :presence => true

end
