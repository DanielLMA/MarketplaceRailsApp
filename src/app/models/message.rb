class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :runner

  validates_presence_of :body, :conversation_id, :runner_id

  def message_time
    created_at.strftime("%d/%m/%y at %l:%M %p")
  end
end
