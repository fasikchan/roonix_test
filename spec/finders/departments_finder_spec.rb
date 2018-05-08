require 'rails_helper'

RSpec.describe DepartmentsFinder do
  let(:service) do
    described_class.new(params)
  end
  let!(:first_department) { create :department }
  let!(:second_department) { create :department }

  describe '#call' do
    context 'when empty params' do
      let(:params) { {} }
      it do
        expect(service.call).to eq [first_department, second_department]
      end
    end

    context 'when single id' do
      let(:params) { {departments_ids: first_department.id} }
      it do
        expect(service.call).to eq [first_department]
      end
    end

    context 'when multiple ids' do
      let(:params) { {departments_ids: [first_department.id, second_department.id]} }
      it do
        expect(service.call).to eq [first_department, second_department]
      end
    end
  end
end
