module Departments
  class UpdateDepartmentService
    attr_reader :department, :params

    PERMITTED_ATTRIBUTES = [
      :department_name
    ].freeze

    def initialize(department, params = {})
      @params = params
      @department = department
    end

    def call
      department.assign_attributes(params.permit(*PERMITTED_ATTRIBUTES))
      department.save! if department.valid?
    end
  end
end