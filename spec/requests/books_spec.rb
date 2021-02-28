require 'rails_helper'

describe 'Books Api', type: :request do
    let(:first_author) { FactoryBot.create(:author, first_name:'jack', last_name:'jack', age: 55)}
    let(:second_author) { FactoryBot.create(:author, first_name:'j', last_name:'jack', age: 40)}
    describe 'index action' do
        before do
            FactoryBot.create(:book, title: 'book1', author: first_author)
            FactoryBot.create(:book, title: 'book2', author: second_author)      
        end    
        it 'returns all the books' do
            get '/api/v1/books'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end    
    end

    describe 'create book action' do
        it 'creates a new book' do
            expect{
            post '/api/v1/books', params: { book: 
                {title: 'hello'},
                 author: {first_name:'hagaaar', last_name:'reda', age: 26}
                }
            }.to change{Book.count}.from(0).to(1)
            expect(response).to have_http_status(200)
            expect(Author.count).to eq(1)

        end
    end

    describe 'destroy action' do
        let!(:book) {FactoryBot.create(:book, title: 'book1', author: first_author)}
        it 'deletes a book' do
            expect{
                delete "/api/v1/books/#{book.id }"
            }.to change{Book.count}.from(1).to(0)
            expect(response).to have_http_status(:no_content)
        end
    end
    
end