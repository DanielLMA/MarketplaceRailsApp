class Conversation < ApplicationRecord
    belongs_to :sender, class_name: "Runner", foreign_key: "sender_id"
    belongs_to :receiver, class_name: "Runner", foreign_key: "receiver_id"
    has_many :messages, :dependent => :delete_all
  
    validates_uniqueness_of :sender_id, scope: :receiver_id
  
    scope :between, -> (sender_id, receiver_id) do
      where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
    end
  
    def recipient(current_runner)
      self.sender_id == current_runner.id ? self.receiver : self.sender
    end
  
    def unread_message_count(current_runner)
      self.messages.where("runner_id != ? AND read = ?", current_runner.id, false).count
    end
  
end
