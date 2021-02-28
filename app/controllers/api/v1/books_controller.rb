module  Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all
      end
    
      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
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
      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end
      def book_params
        params.require(:book).permit(:title)
      end
     
    end
    
  end  
end
