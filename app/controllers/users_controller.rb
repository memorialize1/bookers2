class UsersController < ApplicationController
  
  def edit
    @user = User.find(params[:id])
  end

  def index
    @user = User.find(current_user.id)
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
    
  end
  
  def show
   @user = User.find(params[:id])
   @null = Book.where(params[:id])
   @books = @null.page(params[:page]).reverse_order
   @book = Book.new
  end
  
  def update
    @user = User.find(params[:id])
     if @user.update(users_params)
       flash[:success] = "You have updated book successfully."
       redirect_to new_book_path
     else
       render "/users/edit"
     end
  end
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id #@current_user = :user_id
    if @book.save
       flash[:success] = "You have create book successfully."
       redirect_to new_books_path
    else
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
  
  
end
