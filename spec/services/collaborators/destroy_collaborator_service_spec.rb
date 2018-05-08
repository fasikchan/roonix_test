require 'rails_helper'

RSpec.describe Collaborators::DestroyCollaboratorService do

  let(:service) do
    described_class.new(collaborator)
  end

  describe '#call' do
    context 'when 1 collaborator exists' do
      let!(:collaborator) { create :collaborator }
      let!(:department) { collaborator.departments.first }

      before { service.call }

      it do
        expect(department.reload.collaborators.count).to eq 0
        expect(department.reload.collaborators_quantity).to eq 0
        expect(department.reload.max_salary).to eq nil
      end
    end

    context 'when 2 collaborators exists' do
      let!(:collaborator) { create :collaborator }
      let!(:department) { collaborator.departments.first }
      let!(:second_collaborator) { create :collaborator, departments: [department] }

      before { service.call }
      
      it do
        expect(department.reload.collaborators.count).to eq 1
        expect(department.reload.collaborators_quantity).to eq 1
        expect(department.reload.max_salary).to eq 1000
      end
    end
  end
end
