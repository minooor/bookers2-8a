class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
    else
      flash[:notice] = "メッセージ送信に失敗しました。"
    end
    redirect_to "/rooms/#{@message.room_id}"
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :message)
  end

end
