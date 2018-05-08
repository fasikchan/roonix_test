class DepartmentsFinder
  attr_reader :departments_ids

  def initialize(attributes = {})
    @departments_ids = attributes[:departments_ids]
  end

  def call
    if departments_ids
      departments = Department.where(id: departments_ids)
    else
      departments = Department.all
    end
  end
end