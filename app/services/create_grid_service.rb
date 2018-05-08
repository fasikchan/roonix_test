class CreateGridService
  attr_reader :grid

  def initialize
    @grid = nil
  end

  def call
    collaborators = Collaborator.eager_load(:departments).pluck(:id, :first_name, :last_name, :department_name)
    return if collaborators.blank?
    
    departments = collaborators.uniq { |a| a.last}.map {|a| a.last}

    names_hash = {}
    departments_hash = {}

    collaborators.each do |collaborator|
      departments_hash[collaborator[0]] ||= []
      departments_hash[collaborator[0]][departments.index(collaborator[3])] = "+"
      names_hash[collaborator[0]] = collaborator[1] + " " + collaborator[2]
    end

    @grid = [first_row(departments)] + collaborators_rows(names_hash, departments_hash)
  end

  private

  def first_row(departments)
    [nil] + departments
  end

  def collaborators_rows(names, departments)
    rows = []
    departments.each_pair do |k,v|
      rows << [names[k]] + v
    end
    return rows
  end
end
