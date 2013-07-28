class MessagesController < ApplicationController

  before_filter :authenticate_user!
  
  def create
    message = current_user.outbox.create( :recipient => User.find(params[:user]), :body => params[:message] )
    render :json => message, :include => { :sender => { :methods => :avatar_thumb } }
  end

  def index
    @messages = current_user.inbox.all
  end

  def show
    @conversation = current_user.conversation_with params[:id]
    Message.update_all( { :read_at => Time.now }, [ " sender_id = ? AND recipient_id = ? AND read_at IS NULL", params[:id], current_user.id] )
    render :json => @conversation, :include => { :sender => { :methods => :avatar_thumb } }
  end

end
