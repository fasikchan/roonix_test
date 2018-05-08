class CollaboratorsFinder
  attr_reader :collaborators_ids

  def initialize(attributes = {})
    @collaborators_ids = attributes[:collaborators_ids]
  end

  def call
    if collaborators_ids
      collaborators = Collaborator.where(id: collaborators_ids)
    else
      collaborators = Collaborator.all
    end
  end
end