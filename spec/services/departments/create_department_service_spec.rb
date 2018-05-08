require 'rails_helper'

RSpec.describe Departments::CreateDepartmentService do
  let(:service) do
    described_class.new(ActionController::Parameters.new(params))
  end

  describe '#call' do
    context 'when valid params' do
      let(:params) { {department_name: 'name'} }

      before { service.call }

      it { expect(service.department.department_name).to eq 'name' }
    end

    context 'when no department_name' do
      let(:params) { {department_name: nil} }
      it do
        service.call
        expect(service.department.errors).to include :department_name
      end
    end
  end
end
