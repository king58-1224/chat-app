class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.finnd(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render :index
    end
  end

  private

  def messaage_params
    params.require(:message).permit(:cotent).merge(user_id: current_user.id)
  end
end
