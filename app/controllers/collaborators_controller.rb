class CollaboratorsController < ApplicationController
  def index
    @collaborators = CollaboratorsFinder.new.call
  end

  def show
    @collaborator = CollaboratorsFinder.new(collaborators_ids: params[:id]).call.first
  end

  def new
  end

  def create
    service = Collaborators::CreateCollaboratorService.new(collaborator_params)
    service.call

    @collaborator = service.collaborator
    if @collaborator.errors.blank?
      redirect_to collaborators_path
    else
      flash.now[:error] = @collaborator.errors
      render action: :new
    end
  end

  def edit
    @collaborator = CollaboratorsFinder.new(collaborators_ids: params[:id]).call.first
  end

  def update
    collaborator = CollaboratorsFinder.new(collaborators_ids: params[:id]).call.first
    
    service = Collaborators::UpdateCollaboratorService.new(collaborator, collaborator_params)
    service.call
    
    @collaborator = service.collaborator
    if @collaborator.errors.blank?
      redirect_to collaborator_path(@collaborator.id)
    else
      flash.now[:error] = @collaborator.errors
      render action: :edit
    end
  end

  def destroy
    collaborator = CollaboratorsFinder.new(collaborators_ids: params[:id]).call.first
    
    Collaborators::DestroyCollaboratorService.new(collaborator).call
    
    redirect_to collaborators_path
  end

  private
  
  def collaborator_params
    params.require(:collaborator)
  end
end
