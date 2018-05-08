class CreateDepartment < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.text :department_name, null: false
      t.integer :collaborators_quantity
      t.integer :max_salary
      t.timestamps
    end

    add_index :departments, :department_name
  end
end
