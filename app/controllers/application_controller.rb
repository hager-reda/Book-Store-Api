class ApplicationController < ActionController::API

  before_action :authorized
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      author_id = decoded_token[0]['author_id']
      @author = Author.find_by(id: author_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

    private
    def not_destroyed
        render json: {}, status: :unprocessable_entity
      end
end
