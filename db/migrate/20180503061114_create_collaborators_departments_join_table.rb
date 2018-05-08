class CreateCollaboratorsDepartmentsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :collaborators, :departments do |t|
      t.index :collaborator_id
      t.index :department_id
    end
  end
end
