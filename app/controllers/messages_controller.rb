class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    unless @message.user_id == current_user.id
      @notification = @message.notifications.build(user_id: @message.conversation.recipient_id )
    end
    if @message.save
      redirect_to conversation_messages_path(@conversation)
      unless @message.user_id == current_user.id
        binding.pry
        Pusher.trigger("user_#{@message.user_id}_channel", 'message_created', {
            message: 'あなたにメッセージが届きました'
          })
      end
    else
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
