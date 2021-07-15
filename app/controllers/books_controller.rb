class BooksController < ApplicationController
  def new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  end
  
  def edit
  end
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id #@current_user = :user_id
    @book.save
    redirect_to books_path
      
  end
  
  def update
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def books_params
      params.require(:book).permit(:title, :body, :user_id)
  end
end
