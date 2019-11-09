class ConversationsController < ApplicationController
  before_action :authenticate_runner!
  
  def index
    @runners = Runner.where.not(id: current_runner.id)
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_runner.id, current_runner.id)
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :receiver_id)
    end
end
