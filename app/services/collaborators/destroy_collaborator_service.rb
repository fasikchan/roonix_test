module Collaborators
  class DestroyCollaboratorService
    attr_reader :collaborator

    def initialize(collaborator)
      @collaborator = collaborator
    end

    def call
      department_ids = collaborator.departments.pluck(:id)

      ActiveRecord::Base.transaction do
        collaborator.destroy!
        Department.where(id: department_ids).each do |department|
          department.update_column(:collaborators_quantity, department.collaborators.count)
          department.update_column(:max_salary, department.collaborators.maximum('salary'))
        end
      end
    end
  end
end
