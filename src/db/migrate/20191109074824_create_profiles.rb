class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :age
      t.string :gender
      t.string :pace
      t.string :runningregion
      t.references :runner, foreign_key: true
      t.timestamps
    end
  end
end
