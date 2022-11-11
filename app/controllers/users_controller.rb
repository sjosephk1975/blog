class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html {redirect_to log_in_path(@user), notice: 'User was successfully created.'}
        else 
          format.html { render :new, status: :unprocessable_entity }
        end
      end    
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
