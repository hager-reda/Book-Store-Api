require 'rails_helper'

describe 'Books Api', type: :request do
    describe 'index action' do
        it 'returns all the books' do
            FactoryBot.create(:book, title: 'book1', author: 'hgr')
            FactoryBot.create(:book, title: 'book2', author: 'hgr')
            get '/api/v1/books'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end    
    end

    describe 'create book action' do
        it 'creates a new book' do
            expect{
            post '/api/v1/books', params: { book: {title: 'hello', author: 'hagaaar'}}
            }.to change{Book.count}.from(0).to(1)
            expect(response).to have_http_status(200)

        end
    end

    describe 'destroy action' do
        let!(:book) {FactoryBot.create(:book, title: 'book1', author: 'hgrrr')}
        it 'deletes a book' do
            expect{
                delete "/api/v1/books/#{book.id }"
            }.to change{Book.count}.from(1).to(0)
            expect(response).to have_http_status(:no_content)
        end
    end
    
end