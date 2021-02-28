module  Api
    module V1
        class AuthorsController < ApplicationController
            before_action :authorized, only: [:auto_login]

            # REGISTER
            def create
                @author = Author.create(author_params)
                if @author.valid?
                token = encode_token({author_id: @author.id})
                render json: {author: @author, token: token}
                else
                render json: {error: "Invalid username or password"}
                end
            end

            # LOGGING IN
            def login
                @author = Author.find_by(user_name: params[:user_name])

                if @author && @author.authenticate(params[:password])
                token = encode_token({author_id: @author.id})
                render json: {author: @author, token: token}
                else
                render json: {error: "Invalid username or password"}
                end
            end


            def auto_login
                render json: {
                    messege: "hello #{@author.user_name}",
                }
            end

            private

            def author_params
                params.permit(:first_name, :last_name, :user_name, :password, :age)
            end

        end
    end
end
