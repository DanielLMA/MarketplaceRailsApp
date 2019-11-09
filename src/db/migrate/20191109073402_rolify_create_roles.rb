class RolifyCreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:runners_roles, :id => false) do |t|
      t.references :runner
      t.references :role
    end
    
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:runners_roles, [ :runner_id, :role_id ])
  end
end
