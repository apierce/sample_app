class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"

      # must re-sign in b/c on save, our cookie ID changes
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        # <notice> is an entry in the <flash> hash
        redirect_to signin_url, notice: "Please sign in."
      end
      
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url, notice: "You cannot access that page." unless current_user?(@user)
    end
end
