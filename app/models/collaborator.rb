class Collaborator < ApplicationRecord
  has_and_belongs_to_many :departments
  
  validates :first_name, :last_name, :sex, :salary, presence: true
  validates :sex, inclusion: { in: ['male', 'female'] }
  validate :presence_of_department_validator

  def presence_of_department_validator
    errors.add(:department_ids, :not_exists) if department_ids.blank?
  end
end
