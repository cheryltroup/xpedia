class UsersController < ApplicationController

def show
	@user = User.find(params[:id])
end

def downgrade
	
  current_user.wikis.each do |wiki|	
			wiki.update_attribute(:private, false)
	 end
  current_user.update_attribute(:role, 'standard')
	flash[:alert] = "You now have been downgrade to a standard membership. Your private wikis will become public wikis!"		                      
  redirect_to wikis_path
end 

private

def user_params
	params.require(:user).permit(:name, :role)
end
end

