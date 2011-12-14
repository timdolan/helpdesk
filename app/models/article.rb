class Article < ActiveRecord::Base

  attr_accessor :search
  attr_accessible :title, :article, :keyword, :current, :public

  belongs_to :user

  validates :title,             :presence => true
  validates :article,           :presence => true
  validates :user_id,           :presence => true

end
