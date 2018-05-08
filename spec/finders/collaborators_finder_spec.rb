require 'rails_helper'

RSpec.describe CollaboratorsFinder do
  let(:service) do
    described_class.new(params)
  end
  let!(:first_collaborator) { create :collaborator }
  let!(:second_collaborator) { create :collaborator }

  describe '#call' do
    context 'when empty params' do
      let(:params) { {} }
      it do
        expect(service.call).to eq [first_collaborator, second_collaborator]
      end
    end

    context 'when single id' do
      let(:params) { {collaborators_ids: first_collaborator.id} }
      it do
        expect(service.call).to eq [first_collaborator]
      end
    end

    context 'when multiple ids' do
      let(:params) { {collaborators_ids: [first_collaborator.id, second_collaborator.id]} }
      it do
        expect(service.call).to eq [first_collaborator, second_collaborator]
      end
    end
  end
end
