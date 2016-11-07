class RegistrationsController < Devise::RegistrationsController
	prepend_before_filter :require_no_authentication, :only => [:create, :update]

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:corporate_id, :email, :fullname, :password, :password_confirmation)
  end

end 