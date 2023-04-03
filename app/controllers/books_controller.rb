class BooksController < ApplicationController

        before_action :authorize_request
        before_action :set_book, only: [:show, :update, :destroy]
      
        # GET /books
      def index
  @books = @current_user.books.joins(:category).select('books.*, categories.name as category_name')
  render json: @books
end

     
        # GET /books/1
def show
  category_name = @book.category.name
  render json: { book: @book, category_name: category_name }
end

      
        # POST /books
        def create
          @book = @current_user.books.build(book_params)
      
          if @book.save
            render json: @book, status: :created
          else
            render json: @book.errors, status: :unprocessable_entity
          end
        end
      
        # PATCH/PUT /books/1
        def update
          if @book.update(book_params)
            render json: @book
          else
            render json: @book.errors, status: :unprocessable_entity
          end
        end
      
        # DELETE /books/1
        def destroy
          @book.destroy
        end
      
        private
      
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = @current_user.books.find(params[:id])
        end
      
        # Only allow a trusted parameter "white list" through.
        def book_params
          params.require(:book).permit(:title, :description, :price, :author, :category_id)
        end
      end
      
