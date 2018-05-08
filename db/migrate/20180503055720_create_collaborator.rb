class CreateCollaborator < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.text :second_name, limit: 255
      t.text :sex, null: false
      t.integer :salary, null: false
      t.timestamps
    end

    add_index :collaborators, :last_name
  end
end
