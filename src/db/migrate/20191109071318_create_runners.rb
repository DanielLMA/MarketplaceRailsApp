class CreateRunners < ActiveRecord::Migration[5.2]
  def change
    create_table :runners do |t|
      t.string :index
      t.string :payment
      t.string :edit

      t.timestamps
    end
  end
end
