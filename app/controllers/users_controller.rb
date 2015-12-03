class UsersController < ApplicationController
 
  before_action :authenticate_user!

	def show
		@user = User.find(params[:id])
	end

	def update
  if current_user.update_attributes(user_params)
     flash[:notice] = "User information updated"
     redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
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

