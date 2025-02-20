class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @borrowed_books = @user.borrowings.where(returned_at: nil).includes(:book)
  end
end