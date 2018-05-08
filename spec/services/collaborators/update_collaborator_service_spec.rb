require 'rails_helper'

RSpec.describe Collaborators::UpdateCollaboratorService do
  let!(:collaborator) { create :collaborator }
  let!(:department) { collaborator.departments.first }
  let(:service) do
    described_class.new(collaborator, ActionController::Parameters.new(params))
  end

  describe '#call' do
    context 'when valid params' do
      let(:params) { {first_name: 'updated_name', last_name: 'updated_last_name'} }

      it do
        service.call

        expect(collaborator.reload.first_name).to eq 'updated_name'
        expect(collaborator.reload.last_name).to eq 'updated_last_name'
      end
    end

    context 'when invalid params' do
      let(:params) { {first_name: nil} }
      it do
        service.call

        expect(collaborator.errors).to include :first_name
      end
    end

    context 'when update salary' do
      let(:params) { {salary: 10000} }
      it do
        service.call

        expect(collaborator.reload.salary).to eq 10000
        expect(department.reload.max_salary).to eq 10000
      end
    end

    context 'when update departments' do
      let(:params) { {department_ids: [empty_department.id]} }
      let!(:empty_department) { create :department }

      it do
        service.call

        expect(department.reload.collaborators_quantity).to eq 0
        expect(department.reload.max_salary).to eq nil

        expect(empty_department.reload.collaborators_quantity).to eq 1
        expect(empty_department.reload.max_salary).to eq 1000
      end
    end

    context 'when update departments and salary' do
      let(:params) { {salary: 10000, department_ids: [empty_department.id]} }
      let!(:empty_department) { create :department }

      it do
        service.call
        
        expect(department.reload.collaborators_quantity).to eq 0
        expect(department.reload.max_salary).to eq nil

        expect(empty_department.reload.collaborators_quantity).to eq 1
        expect(empty_department.reload.max_salary).to eq 10000
      end
    end
  end
end