require 'rails_helper'
require 'monkeypatch'
require 'simplecov'
SimpleCov.start 'rails'
require 'database_cleaner'

# DatabaseCleaner.strategy = :truncation

# # # then, whenever you need to clean the DB
# DatabaseCleaner.clean

RSpec.describe MoviesController, type: :controller do
    describe "#index" do
        it "shows all the movies" do
            movie_0 = Movie.create(title: 'movie_0', director: 'director1', rating:'G', release_date: '2021-01-01')
            movie_1 = Movie.create(title: 'movie_1', director: 'director2', rating:'R', release_date: '2021-03-11')
            get :index
            expect(assigns(:movies)).to eq [movie_0, movie_1]
        end
    end
    
    describe "#show" do
        it "shows info of the movie" do
            movie_0 = Movie.create(title: 'movie_0', director: 'director1', rating:'G', release_date: '2021-01-01')
            get :show, id: movie_0.id
            expect(response).to render_template :show
        end
    end
    
    describe "#edit" do
        it "shows editing format of the movie" do
            movie_0 = Movie.create(title: 'movie_0', director: 'director1', rating:'G', release_date: '2021-01-01')
            get :edit, id: movie_0.id
            expect(response).to render_template :edit
        end
    end
    
    describe "#new" do
        it "shows creating format of a movie" do
            get :new
            expect(response).to render_template :new
        end
    end
    
    describe "#update" do
        it "updates the movie" do
            movie_0 = Movie.create(title: 'movie_0', director: 'director1', rating:'G', release_date: '2021-01-01')
            put :update, id: movie_0.id, movie: {title: 'movie_new', director: 'director_new', rating:'R', release_date: '2021-03-11'}
            movie_0.reload
            expect(movie_0.title).to eq('movie_new')
            expect(movie_0.director).to eq('director_new')
            expect(movie_0.rating).to eq('R')
            expect(movie_0.release_date).to eq('2021-03-11')
            expect(flash[:notice]).to eq("#{movie_0.title} was successfully updated.")
            expect(response).to redirect_to(movie_0)
        end
    end
    
    describe "#create" do
        it "creates a new movie" do
            count= Movie.count
            post :create, movie: {title: 'movie_new', director: 'director_new', rating:'R', release_date: '2021-03-11'}
            expect(flash[:notice]).to eq "movie_new was successfully created."
            expect(Movie.count).to eq(count+1)
            expect(response).to redirect_to(movies_path)
        end 
    end
    
    describe "#destroy" do
        it "destroies the movie" do
            movie_0 = Movie.create(title: 'movie_0', director: 'director1', rating:'G', release_date: '2021-01-01')
            count= Movie.count
            delete :destroy, id: movie_0.id
            expect(flash[:notice]).to eq "Movie 'movie_0' deleted."
            expect(Movie.count).to eq(count-1)
            expect(response).to redirect_to movies_path
        end
    end
    
    describe "searches movies with same director" do
        it "finds movies with same director" do
            movie_1 = Movie.create(title: 'movie_1', director: 'director1')
            movie_2 = Movie.create(title: 'movie_2', director: 'director1')
            movie_3 = Movie.create(title: 'movie_3', director: 'director2')
            movie_4 = Movie.create(title: 'movie_4')
            get :similardirector, id: movie_1.id
            expect(assigns(:movies)).to eq [movie_1, movie_2]
        end
        it "finds only this movie" do
            movie_1 = Movie.create(title: 'movie_1', director: 'director1')
            movie_2 = Movie.create(title: 'movie_2', director: 'director1')
            movie_3 = Movie.create(title: 'movie_3', director: 'director2')
            movie_4 = Movie.create(title: 'movie_4')
            get :similardirector, id: movie_3.id
            expect(assigns(:movie)).to eq movie_3
        end
        it "has no director information" do
            movie_1 = Movie.create(title: 'movie_1', director: 'director1')
            movie_2 = Movie.create(title: 'movie_2', director: 'director1')
            movie_3 = Movie.create(title: 'movie_3', director: 'director2')
            movie_4 = Movie.create(title: 'movie_4')
            get :similardirector, id: movie_4.id
            expect(flash[:notice]).to eq "'movie_4' has no director info."
            expect(response).to redirect_to movies_path
        end
            
    end
end