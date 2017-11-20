class BooksController < ApplicationController
  def show
    @book = Book.find params[:id]
    @order_item = BsCheckout::OrderItem.new
  end
end
