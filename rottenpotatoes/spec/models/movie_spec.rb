require 'rails_helper'
require 'monkeypatch'
require 'simplecov'
SimpleCov.start 'rails'
require 'database_cleaner'

# DatabaseCleaner.strategy = :truncation

# # then, whenever you need to clean the DB
# DatabaseCleaner.clean

RSpec.describe Movie, type: :model do
    it "returns similar movies" do
        movie_1 = Movie.create(title: 'movie_1', director: 'director1')
        movie_2 = Movie.create(title: 'movie_2', director: 'director1')
        movie_3 = Movie.create(title: 'movie_3', director: 'director2')
        expect(movie_1.others_by_same_director('director1')) == [movie_1, movie_2]
        expect(movie_1.others_by_same_director('director1')) != [movie_1, movie_2, movie_3]
    end
        
end