class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success]="Micropost created!"
      redirect_to root_url
    else
      @feed_items =[]
      render 'static_pages/home'
    end

  end

  def show
    @micropost = Micropost.find(params[:id])
  end
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?

    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end


  # def destroy
  #   @micropost.destroy
  #   binding.pry
  #   flash[:success]="Micropost deleted"
  #   redirect_to request.referrer || root_url
  # end

  private
  def micropost_params
    params.require(:micropost).permit(:content , :image)
  end

  def correct_user
    @micropost=current_user.microposts.find_by(id:params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
