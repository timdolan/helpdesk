class Article < ActiveRecord::Base

  attr_accessor :search
  attr_accessible :title, :article

  belongs_to :user

  validates :title,             :presence => true
  validates :article,           :presence => true
  validates :user_id,           :presence => true

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ? OR article LIKE ?', search_condition, search_condition])
  end

end
