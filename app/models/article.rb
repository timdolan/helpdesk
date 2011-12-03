class Article < ActiveRecord::Base

  attr_accessible :title, :article

  belongs_to :user

  validates :title,             :presence => true
  validates :article,           :presence => true
  validates :user_id,           :presence => true

end
