require 'rails_helper'
require 'monkeypatch'
require 'simplecov'
SimpleCov.start 'rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

# # then, whenever you need to clean the DB
DatabaseCleaner.clean

RSpec.describe MoviesController, type: :controller do
    
    movie_1 = Movie.create(title: 'movie_1', director: 'director1')
    movie_2 = Movie.create(title: 'movie_2', director: 'director1')
    movie_3 = Movie.create(title: 'movie_3', director: 'director2')
    movie_4 = Movie.create(title: 'movie_4')
    describe "searches movies with same director" do
        it "finds movies with same director" do
            get :similardirector, id: movie_1.id
            expect(assigns(:movies)).to eq [movie_1, movie_2]
        end
        it "finds only this movie" do
            get :similardirector, id: movie_3.id
            expect(assigns(:movie)).to eq movie_3
        end
        it "has no director information" do
            get :similardirector, id: movie_4.id
            expect(flash[:notice]).to eq "'movie_4' has no director info."
            expect(response).to redirect_to movies_path
        end
            
    end
        
end