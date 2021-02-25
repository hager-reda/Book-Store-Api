module  Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all
      end
    
      def create
        book = Book.new(book_params)
        if book.save
          render json:{
            status: 200,
            messege: "Book Created",
            book: book
          }
        else
          render json:{
            status: 500,
            errors: book.errors
          }
        end
      end
        def destroy
          book = Book.find(params[:id])
          book.destroy!
          head :no_content
          #handling the exception
        # rescue ActiveRecord::RecordNotDestroyed
          # render json: {}, status: :unprocessable_entity
        end
          # render json:{
          #   status: 200,
          #   messege: "deleted"
          # }
        # end
    
      private
      def book_params
        params.require(:book).permit(:title, :author)
      end
     
    end
    
  end  
end
