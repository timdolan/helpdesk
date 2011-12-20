class CommentsController < ApplicationController
  
  before_filter :authenticate, :only => [:show, :new, :create]
  before_filter :admin_user, :only => [:edit, :update, :destroy]

  def index
    @comment = Comment.where("ticket_id = ? and created_at > ?", params[:ticket_id], Time.at(params[:after].to_i + 1))
  end

  def show
    @comment = Comment.find(params[:id])
    @ticket = Ticket.find(params[:ticket_id])
    @title = @comment.title
  end
  
  def new
    @title = "Create Comment" 
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.new
  end
  
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment Submitted Successfully"
      if @ticket.status != @comment.status
        @ticket.update_attributes(:status => @comment.status)
      end
      redirect_to ticket_path(@ticket)
    else
      @title = "Create Comment"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Ticket"
    @comments = Comment.find(params[:id])
    
  end
  
  def update
    @comments = Comment.find(params[:id])
    if @comments.update_attributes(params[:comments])
      flash[:success] = "Ticket comment updated"
      redirect_to ticket_path(@ticket)
    else
      @title = "Edit Ticket Comment"
      render 'edit'
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Ticket comment deleted."
    redirect_to root_path 
  end

end
