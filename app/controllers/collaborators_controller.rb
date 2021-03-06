class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
    collaborators_ids = @wiki.collaborators(:select => :user_id).collect(&:user_id)
    @wiki_users = User.where(id: collaborators_ids)
    @non_wiki_users = User.where.not(id: collaborators_ids)
  end

  def new
  end

  def create
    @wiki = Wiki.find params[:wiki_id]
    @user = User.find params[:user_id]
    @collaborator = Collaborator.create(user_id: @user.id, wiki_id: @wiki.id)

    if @collaborator.save
      flash[:notice] = "Collaborator was added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Error saving collaborator. Please try again."
      render :new
    end
  end

  def show
    @collaborator = Collaborator.find(params[:wiki_id])
  end

  def destroy
    @collaborator = Collaborator.find_by_user_id_and_wiki_id(params[:id],params[:wiki_id])

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
