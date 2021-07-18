class BooksController < ApplicationController

before_action :ensure_correct_user, only:[:edit, :update]
before_action :create_book

  def index
    @books = Book.page(params[:page]).reverse_order
    @user = current_user
  end
  

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def create
    @create = Book.new(books_params)
    @create.user_id = current_user.id #@current_user = :user_id
    if @create.save
       flash[:success] = "You have create book successfully."
       redirect_to book_path(@create.id)
    else
       @user = current_user
       @books = Book.page(params[:page]).reverse_order
       render "/books/index"
    end
      
  end
  
  def update
    @book = Book.find(params[:id])
     if @book.update(books_params)
       flash[:success] = "You have updated book successfully."
       redirect_to book_path(@book.id)
     else
       render :edit
     end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def create_book
    @create = Book.new
  end
  
  def books_params
      params.require(:book).permit(:title, :body, :user_id)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
      if current_user != @book.user
        redirect_to user_path(current_user)
      end
    
  end
  
end
