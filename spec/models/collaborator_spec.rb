require 'rails_helper'

RSpec.describe Collaborator do
  describe 'order validation' do
    context 'valid' do
      let(:collaborator) { build :collaborator }

      it { expect(collaborator.valid?).to be_truthy }
    end

    context 'invalid by first_name' do
      let(:collaborator) { build :collaborator, first_name: nil }

      it { expect(collaborator.valid?).to be_falsey }
    end

    context 'invalid by last_name' do
      let(:collaborator) { build :collaborator, last_name: nil }

      it { expect(collaborator.valid?).to be_falsey }
    end
  end
end