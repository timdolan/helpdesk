class PagesController < ApplicationController
  def index
    @bulletin = Bulletin.where("current = ? AND public = ?", true, true)
    @ticket = Ticket.where("contact = ?", current_user)
  end
  
  def faq
  end
end