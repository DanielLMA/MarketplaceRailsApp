class AddPaidToRunners < ActiveRecord::Migration[5.2]
  def change
    add_column :runners, :paid, :boolean, default: false
  end
end
