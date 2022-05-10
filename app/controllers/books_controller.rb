class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @book_favorite_ranks = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end 
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:alert] = "You have created book successfully."
      redirect_to book_path(@book.id)
      
    else
      @user = current_user
      @books = Book.all
      render :index
    end  
  end
  
  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end
  

  

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:alert] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'books/edit'
    end  
  end
  
  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    # flash[:alert] = "Book was successfully destroyed"
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
