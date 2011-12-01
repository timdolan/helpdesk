class PagesController < ApplicationController
  def index
    @bulletin = Bulletin.where("current = ? AND public = ?", true, true)
  end
  
  def faq
  end
end