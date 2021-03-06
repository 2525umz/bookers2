class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show, :index, :edit]



  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome!You have signed up successfully.'
      redirect_to login_path
    else
      @user = User.find(params[:id])
      @book = Book.new
      @books = Book.where(user_id: @user.id)
      render :show
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end
  
  

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :mail, :password,)
  end

end
