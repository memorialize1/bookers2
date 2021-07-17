class UsersController < ApplicationController
  
  
  before_action :ensure_correct_user, only:[:edit, :update]
  before_action :create_book
  
  
  def edit
      @user = User.find(params[:id])
  end

  def index
    @user = current_user
    @users = User.page(params[:page]).reverse_order
    
  end
  
  def show
   @user = User.find(params[:id])
   null = Book.where(user_id: params[:id])
   @books = null.page(params[:page]).reverse_order
  end
  
  def update
    @user = User.find(params[:id])
     if @user.update(users_params)
        flash[:success] = "You have updated user successfully."
        redirect_to user_path(current_user)
     else
        render "/user/edit"
     end
  end
  
  def create
    @create = Book.new(books_params)
    @create.user_id = current_user.id #@current_user = :user_id
    if @create.save
       flash[:success] = "You have create book successfully."
       redirect_to book_path(@create.id)
    else
       @user = current_user
       null = Book.where(user_id: params[:id])
       @books = null.page(params[:page]).reverse_order
       render "/users/show"
    end
  end
  
  
  private
  
  def users_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def books_params
      params.require(:book).permit(:title, :body, :user_id)
  end
  
  def ensure_correct_user
      @post = Book.find(params[:id])
      if current_user.id == @post.id
        @user = User.find(params[:id])
        render :edit
      else
        redirect_to user_path(current_user)
      end
    
  end
  
  def create_book
    @create = Book.new
  end
  
end
