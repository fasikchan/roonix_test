require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do

  describe '#index' do
    context 'when collaborators exist' do
      let!(:collaborator) { create :collaborator }
      let!(:department) { collaborator.departments.first }

      it do
        get :index

        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
        expect(assigns(:collaborators)).to eq [collaborator]
      end
    end

    context 'when collaborators dont exist' do
      it do
        get :index

        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
        expect(assigns(:collaborators)).to eq []
      end
    end
  end
 
  describe '#show' do
    context 'when collaborator exists' do
      let!(:collaborator) { create :collaborator }
      let!(:department) { collaborator.departments.first }

      it do
        get :show, params: {id: collaborator.id}

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(assigns(:collaborator)).to eq collaborator
      end
    end

    context 'when collaborator dont exists' do
      it do
        get :show, params: {id: 111111}

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(assigns(:collaborator)).to eq nil
      end
    end
  end

  describe '#update' do
    let!(:collaborator) { create :collaborator }
    let!(:department) { collaborator.departments.first }
    
    context "when valid params" do
      it do
        put :update, params: {id: collaborator.id, collaborator: {salary: 10000}}

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(collaborator_path(assigns(:collaborator)))
        expect(assigns(:collaborator)).to eq collaborator
        expect(collaborator.reload.salary).to eq 10000
      end
    end

    context "when invalid params" do
      it do
        put :update, params: {id: collaborator.id, collaborator: {salary: nil}}

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        expect(assigns(:collaborator)).to eq collaborator
        expect(collaborator.reload.salary).to eq 1000
      end
    end
  end

  describe '#create' do
    let!(:department) { create :department }

    context "when valid params" do
      it do
        post :create, params: {collaborator: {first_name: "name", last_name: "lname", sex: :male, salary: 1, department_ids: [department.id]}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(collaborators_path)
      end
    end

    context "when invalid params" do
      it do
        post :create, params: {collaborator: {first_name: "name", last_name: "lname", salary: nil, department_ids: [department.id]}}
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#destroy' do
    let!(:collaborator) { create :collaborator }

    it do
      delete :destroy, params: {id: collaborator.id}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(collaborators_path)
    end
  end
end
