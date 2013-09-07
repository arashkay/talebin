class MessagesController < ApplicationController

  before_filter :authenticate_user!
  
  def create
    message = current_user.outbox.create( :recipient => User.find(params[:user]), :body => params[:message] )
    render :json => message, :include => { :sender => { :methods => :avatar_thumb } }
  end

  def index
    @messages = current_user.inbox.all
  end

  def list
    if params[:type].blank?
      @messages = Message.where( :read_at => nil ).order('created_at DESC').paginate :page => params[:page]
    elsif params[:type] == 'conversation'
      @messages = Message.select( "count(sender_id) as cnt,sender_id,body,recipient_id,created_at,read_at" ).group('sender_id').order('cnt DESC').paginate :page => params[:page]
    end
  end

  def show
    @conversation = current_user.conversation_with params[:id]
    Message.update_all( { :read_at => Time.now }, [ " sender_id = ? AND recipient_id = ? AND read_at IS NULL", params[:id], current_user.id] )
    render :json => @conversation, :include => { :sender => { :methods => :avatar_thumb } }
  end

end
