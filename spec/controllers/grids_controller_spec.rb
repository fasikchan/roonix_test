require 'rails_helper'

RSpec.describe GridsController, type: :controller do

  describe '#index' do
    context 'when collaborators exists' do
      let!(:collaborator) { create :collaborator }

      it do
        get :index

        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
        expect(assigns(:grid)).to include [collaborator.first_name + " " + collaborator.last_name, "+"]
      end
    end

    context 'when no collaborators' do
      it do
        get :index

        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
        expect(assigns(:grid)).to eq nil
      end
    end
  end
end