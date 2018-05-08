module Collaborators
  class CreateCollaboratorService
    attr_reader :collaborator, :params

    PERMITTED_ATTRIBUTES = [
      :first_name,
      :last_name,
      :second_name,
      :sex,
      :salary
    ].freeze

    def initialize(params)
      @params = params
      @collaborator = Collaborator.new
    end

    def call
      collaborator.assign_attributes(params.permit(*PERMITTED_ATTRIBUTES))
      
      ActiveRecord::Base.transaction do
        collaborator.departments << Department.where(id: params[:department_ids])
        if collaborator.valid?
          collaborator.save!
          
          collaborator.departments.each do |department|
            department.update_column(:collaborators_quantity, department.collaborators_quantity.to_i + 1)
            department.update_column(:max_salary, collaborator.salary) if department.max_salary.to_i < collaborator.salary.to_i
          end
        end
      end
    end
  end
end
