require 'rails_helper'

describe 'Authentication API', type: :request do
    describe 'POST/authenticate' do
        it 'authenticates the client' do
            post '/api/v1/authenticate'
        end
    end
end