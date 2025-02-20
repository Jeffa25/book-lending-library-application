class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    @book = Book.find(params[:id])
    borrowing = current_user.borrowings.new(book: @book, due_date: 2.weeks.from_now)
    if borrowing.save
      redirect_to @book, notice: "Book borrowed successfully."
    else
      redirect_to @book, alert: borrowing.errors.full_messages.to_sentence
    end
  end

  def return
    @book = Book.find(params[:id])
    borrowing = current_user.borrowings.find_by(book: @book, returned_at: nil)
    if borrowing&.update(returned_at: Time.current)
      redirect_to @book, notice: "Book returned successfully."
    else
      redirect_to @book, alert: "Unable to return book."
    end
  end
end