require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  describe '#index' do
    context 'when departments exist' do
      let!(:department) { create :department }

      it do
        get :index

        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
        expect(assigns(:departments)).to eq [department]
      end
    end

    context 'when departments dont exist' do
      it do
        get :index

        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
        expect(assigns(:departments)).to eq []
      end
    end
  end
 
  describe '#show' do
    context 'when department exists' do
      let!(:department) { create :department }

      it do
        get :show, params: {id: department.id}

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(assigns(:department)).to eq department
      end
    end

    context 'when collaborator dont exists' do
      it do
        get :show, params: {id: 111111}

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(assigns(:department)).to eq nil
      end
    end
  end

  describe '#update' do
    let!(:department) { create :department, department_name: 'name' }
    
    context "when valid params" do
      it do
        put :update, params: {id: department.id, department: {department_name: 'new_name'}}

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(department_path(assigns(:department)))
        expect(assigns(:department)).to eq department
        expect(department.reload.department_name).to eq 'new_name'
      end
    end

    context "when invalid params" do
      it do
        put :update, params: {id: department.id, department: {department_name: nil}}

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        expect(assigns(:department)).to eq department
        expect(department.reload.department_name).to eq 'name'
      end
    end
  end

  describe '#create' do
    context "when valid params" do
      it do
        post :create, params: {department: {department_name: "name"}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(departments_path)
      end
    end

    context "when invalid params" do
      it do
        post :create, params: {department: {department_name: nil}}
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#destroy' do
    context "when department without collaborators" do
      let!(:department) { create :department }
      it do
        delete :destroy, params: {id: department.id}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(departments_path)
      end
    end

    context "when department with collaborators" do
      let!(:collaborator) { create :collaborator }
      let!(:department) { collaborator.departments.first }

      it do
        delete :destroy, params: {id: department.id}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(department_path(assigns(:department)))
        expect(assigns(:department)).to eq department
      end
    end
  end
end
