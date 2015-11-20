class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
    # get IDs of all collaborators for the current wiki
    collaborators_ids = @wiki.collaborators(:select => :id).collect(&:id)
    # Users that match collaborator IDs
    @wiki_users = User.where(id: collaborators_ids)
    # Users that do not match collaborator IDs
    @non_wiki_users = User.where.not(id: collaborators_ids)
  end

  def new
  end

  def create

    #@user = current_user
    @wiki = Wiki.find params[:wiki_id]
    @user = User.find params[:user_id]
    @wiki.collaborators.create user: @user

    #if @collaborator.save
      flash[:notice] = "Collaborator was saved."
      redirect_to edit_wiki_path(@wiki)
    #else
    # flash[:error] = "Error saving collaborator. Please try again."
    # render :new
    #end

  end

  def show
    @collaborator = Collaborator.find(params[:wiki_id])
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find params[:id]
    if @collaborator.destroy
      flash[:notice] = "Collaborator was sucessfully deleted."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error. Please try again."
      render :show
    end
  end

private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end
