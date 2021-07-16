class BooksController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @null = Book.where(user_id: current_user.id)
    @books = @null.page(params[:page]).reverse_order
    @book = Book.new
  end

  def index
    @books = Book.page(params[:page]).reverse_order
    @book = Book.new
    @user = User.find(current_user.id)
  end
  
  def porigon
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id #@current_user = :user_id
    if @book.save
       flash[:success] = "You have create book successfully."
       redirect_to book_path(@book.id)
    else
       render "/users/show"
    end
      
  end
  
  def update
    @book = Book.find(params[:id])
     if @book.update(books_params)
       flash[:success] = "You have updated book successfully."
       redirect_to book_path(@book.id)
     else
       render "/books/edit"
     end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to book_user_path(@book.user_id)
  end
  
  private
  
  
  def books_params
      params.require(:book).permit(:title, :body, :user_id)
  end
end
