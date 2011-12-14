class PagesController < ApplicationController

  before_filter :worker_user, :only => [:worker, :open_worker]
  
  def index
    @bulletin = Bulletin.where("current = ? AND public = ?", true, true)
    @ticket = Ticket.where("contact = ?", current_user).paginate(:page => params[:page], :per_page => "15")
    @ticket_title = "My Tickets"
  end
  
  def worker
    @bulletin = Bulletin.where("current = ?", true)
    @ticket = Ticket.where("assigned_to = ?", current_user).paginate(:page => params[:page], :per_page => "15")
    @ticket_title = "All Tickets Assigned To Me"
    render 'index'
  end
  
  def open_worker
    @bulletin = Bulletin.where("current = ?", true)
    @ticket = Ticket.where("assigned_to = ? AND status != ? AND status != ?", current_user, "resolved", "closed").paginate(:page => params[:page], :per_page => "15")
    @ticket_title = "Open Tickets Assigned To Me"
    render 'index'
  end
  
end