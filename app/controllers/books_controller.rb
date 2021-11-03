class BooksController < ApplicationController

   before_action :authenticate_user!, only: [:show, :index, :edit]

 def index
 @book = Book.new
 @books = Book.all
 @user = current_user

 end


 def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
   redirect_to book_path(@book.id), notice: 'You have created book successfully.'
   else
    @books = Book.all
    @user = current_user
    render :index
   end
 end

 def update
  @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice]="You have book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
 end



 def show
  @user = current_user
  @booknew = Book.new
  @book = Book.find(params[:id])

 end


 def edit
   @book = Book.find(params[:id])
  if @book.user == current_user
   render "edit"
  else
   redirect_to books_path
  end
 end

 def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
 end

 private


 def book_params
    params.require(:book).permit(:title, :body)
 end

end
