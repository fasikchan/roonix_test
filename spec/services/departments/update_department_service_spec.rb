require 'rails_helper'

RSpec.describe Departments::UpdateDepartmentService do
  let(:service) do
    described_class.new(department, ActionController::Parameters.new(params))
  end
  let(:department) { create(:department) }

  describe '#call' do
    context 'when valid params' do
      let(:params) { {department_name: 'updated_name'} }

      before { service.call }

      it { expect(department.reload.department_name).to eq 'updated_name' }
    end

    context 'when invalid params' do
      let(:params) { {department_name: nil} }

      before { service.call }

      it { expect(department.errors).to include :department_name }
    end
  end
end