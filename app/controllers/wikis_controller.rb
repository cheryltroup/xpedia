class WikisController < ApplicationController
  def index
    #@wikis = Wiki.all
    #@wikis = Wiki.visible_to(current_user)
    @wikis = policy_scope(Wiki)
  end

  def show
  	@wiki = Wiki.find(params[:id])
  
  end

  def new
    @wiki = Wiki.new
  end

 def create
     @wiki = Wiki.new(wiki_params)
     @wiki.user = current_user
     authorize @wiki 
     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :new
     end
   end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
     @wiki = Wiki.find(params[:id])
     @wiki.user = current_user
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.destroy
    flash[:notice] = "Wiki was successfully deleted."
    redirect_to @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
