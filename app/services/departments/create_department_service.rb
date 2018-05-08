module Departments
  class CreateDepartmentService
    attr_reader :department, :params

    PERMITTED_ATTRIBUTES = [
      :department_name
    ].freeze

    def initialize(params)
      @params = params
      @department = Department.new
    end

    def call
      department.assign_attributes(params.permit(*PERMITTED_ATTRIBUTES))
      department.save! if department.valid?
    end
  end
end