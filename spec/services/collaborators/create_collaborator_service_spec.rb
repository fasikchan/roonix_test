require 'rails_helper'

RSpec.describe Collaborators::CreateCollaboratorService do
  let(:service) do
    described_class.new(ActionController::Parameters.new(params))
  end
  let!(:department) { create :department }

  describe '#call' do
    context 'when valid params' do
      let(:params) do
        {
          first_name: 'name',
          last_name: 'last',
          second_name: 'second',
          sex: :male,
          salary: 1000,
          department_ids: [department.id]
        }
      end

      it do
        service.call
        expect(service.collaborator.first_name).to eq 'name'
        expect(service.collaborator.last_name).to eq 'last'
        expect(service.collaborator.second_name).to eq 'second'
        expect(service.collaborator.sex).to eq 'male'
        expect(service.collaborator.salary).to eq 1000

        expect(department.reload.collaborators_quantity).to eq 1
        expect(department.reload.max_salary).to eq 1000
      end
    end

    context 'when no first_name' do
      let(:params) { {last_name: 'last', sex: :male, salary: 1, department_ids: [department.id] } }
      it do
        service.call
        expect(service.collaborator.errors).to include :first_name
      end
    end

    context 'when no last_name' do
      let(:params) { {first_name: 'name', sex: :male, salary: 1, department_ids: [department.id] } }
      it do
        service.call
        expect(service.collaborator.errors).to include :last_name
      end
    end

    context 'when invalid sex' do
      let(:params) { {first_name: 'name', last_name: 'last', sex: :aaa, salary: 1, department_ids: [department.id] } }
      it do
        service.call
        expect(service.collaborator.errors).to include :sex
      end
    end

    context 'when no salary' do
      let(:params) { {first_name: 'name', last_name: 'last', sex: :male, department_ids: [department.id] } }
      it do
        service.call
        expect(service.collaborator.errors).to include :salary
      end
    end

    context 'when no departments' do
      let(:params) { {first_name: 'name', last_name: 'last', sex: :male, salary: 1} }
      it do
        service.call
        expect(service.collaborator.errors).to include :department_ids
      end
    end
  end
end
