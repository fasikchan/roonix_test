class Department < ActiveRecord::Base
  has_and_belongs_to_many :collaborators

  validates :department_name, presence: true
  
  before_destroy :validate_presence_of_collaborators
  after_create :init_department_attributes

  private

  def init_department_attributes
    update_column(:collaborators_quantity, collaborators.count)
    update_column(:max_salary, collaborators.maximum('salary'))
  end

  def validate_presence_of_collaborators
    unless collaborator_ids.blank?
      errors.add(:collaborator_ids, :exists)
      throw :abort
    end
  end
end
