class DepartmentsController < ApplicationController
  def index
    @departments = DepartmentsFinder.new.call
  end

  def show
    @department = DepartmentsFinder.new(departments_ids: params[:id]).call.first
  end

  def new
  end

  def create
    service = Departments::CreateDepartmentService.new(departments_params)
    service.call
    
    @department = service.department
    if @department.errors.blank?
      redirect_to departments_path
    else
      flash.now[:error] = @department.errors
      render action: :new
    end
  end

  def edit
    @department = DepartmentsFinder.new(departments_ids: params[:id]).call.first
  end

  def update
    department = DepartmentsFinder.new(departments_ids: params[:id]).call.first
    
    service = Departments::UpdateDepartmentService.new(department, departments_params)
    service.call

    @department = service.department
    if @department.errors.blank?
      redirect_to department_path(@department.id)
    else
      flash.now[:error] = @department.errors
      render action: :edit
    end
  end

  def destroy
    department = DepartmentsFinder.new(departments_ids: params[:id]).call.first

    service = Departments::DestroyDepartmentService.new(department)
    service.call
    
    @department = service.department
    if @department.errors.blank?
      redirect_to departments_path
    else
      flash[:error] = @department.errors
      redirect_to department_path(@department.id)
    end
  end

  private
  
  def departments_params
    params.require(:department)
  end
end