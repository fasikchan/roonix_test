require 'rails_helper'

RSpec.describe Department do
  describe 'order validation' do
    context 'valid' do
      let(:department) { build :department }

      it { expect(department.valid?).to be_truthy }
    end

    context 'invalid by department_name' do
      let(:department) { build :department, department_name: nil }

      it { expect(department.valid?).to be_falsey }
    end
  end
end