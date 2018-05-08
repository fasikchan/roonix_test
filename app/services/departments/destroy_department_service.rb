module Departments
  class DestroyDepartmentService
    attr_reader :department

    def initialize(department)
      @department = department
    end

    def call
      department.destroy if department.valid?
    end
  end
end
