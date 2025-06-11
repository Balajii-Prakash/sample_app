class UsersController < ApplicationController
  def new
    @user=User.new

  end

  def show
    @user =User.find(params[:id])
    # debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save #If the user is successfuly saved to the db
      log_in @user # log_in is a method defined in the SessionsHelper module
      flash[:success] = "Welcome to the Sample App!"  
      redirect_to @user #


    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end



