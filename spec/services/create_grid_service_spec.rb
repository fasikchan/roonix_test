require 'rails_helper'

RSpec.describe CreateGridService do
  let(:service) do
    described_class.new
  end

  describe '#call' do
    let!(:first_collaborator) { create :collaborator }
    let!(:second_collaborator) { create :collaborator }

    let(:first_department) { first_collaborator.departments.first }
    let(:second_department) { second_collaborator.departments.first }
    
    before { service.call }

    it do
      expect(service.grid).to include [nil, first_department.department_name, second_department.department_name]
      expect(service.grid).to include [first_collaborator.first_name + " " + first_collaborator.last_name, "+"]
      expect(service.grid).to include [second_collaborator.first_name + " " + second_collaborator.last_name, nil, "+"]
    end
  end
end
