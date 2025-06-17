class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only:[:edit, :update, :show]
  before_action :admin_user , only: :destroy
  def new
    @user=User.new
  end
  def index
    # @users=User.paginate(params[:page])
    @users = User.paginate(page: params[:page])
  end
  def show
    @user =User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)

    if @user.save #If the user is successfully saved to the db
      log_in @user # log_in is a method defined in the SessionsHelper module

      flash[:success] = "Welcome to the Sample App!"  
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render 'new'
    end
  end
  def edit
    @user=User.find(params[:id])
  end
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      #Handle a successful update
      flash[:success]= "Profile updated"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User deleted"
    redirect_to users_url
  end
  #Defines a proto-feed
  # see "Following users" for the full implementation
  def feed
    Micropost.where("user_id = ?",id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :phone_number)
  end


  def correct_user
    @user =User.find(params[:id])
    redirect_to(root_url) unless @user==current_user
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end



