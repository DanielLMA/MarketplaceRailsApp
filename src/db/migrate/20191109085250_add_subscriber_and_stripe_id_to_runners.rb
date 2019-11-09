class AddSubscriberAndStripeIdToRunners < ActiveRecord::Migration[5.2]
  def change
    add_column :runners, :subscribed, :boolean
    add_column :runners, :stripeid, :string
  end
end
