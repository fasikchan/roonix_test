module Collaborators
  class UpdateCollaboratorService
    attr_reader :collaborator, :params

    PERMITTED_ATTRIBUTES = [
      :first_name,
      :last_name,
      :second_name,
      :sex,
      :salary
    ].freeze

    def initialize(collaborator, params = {})
      @params = params
      @collaborator = collaborator
    end

    def call
      department_ids = collaborator.departments.pluck(:id) if salary_changed? || departments_changed?

      collaborator.assign_attributes(params.permit(*PERMITTED_ATTRIBUTES))
      
      if collaborator.valid?
        ActiveRecord::Base.transaction do
          collaborator.save!
          if departments_changed?
            collaborator.departments.delete_all
            collaborator.departments << Department.where(id: params[:department_ids])
          end

          if salary_changed? || departments_changed?
            department_ids += collaborator.departments.pluck(:id)
            department_ids.uniq!

            Department.where(id: department_ids).each do |department|
              department.update_column(:collaborators_quantity, department.collaborators.count) if departments_changed?
              department.update_column(:max_salary, department.collaborators.maximum('salary'))
            end
          end
        end
      end
    end

    private

    def salary_changed?
      @salary_changed ||= !params[:salary].blank?
    end

    def departments_changed?
      @departments_changed ||= !params[:department_ids].blank?
    end
  end
end
