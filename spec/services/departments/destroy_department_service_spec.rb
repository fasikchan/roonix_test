require 'rails_helper'

RSpec.describe Departments::DestroyDepartmentService do

  let(:service) do
    described_class.new(department)
  end

  describe '#call' do
    context 'when department w/o collaborators' do
      let!(:department) { create(:department) }

      before { service.call }
      
      it { expect(Department.count).to eq 0 }
    end

    context 'when department with collaborators' do
      let!(:collaborator) { create :collaborator }
      let!(:department) { collaborator.departments.first }

      before { service.call }

      it do
        expect(Department.count).to eq 1
        expect(department.errors).to include :collaborator_ids
      end
    end
  end
end
