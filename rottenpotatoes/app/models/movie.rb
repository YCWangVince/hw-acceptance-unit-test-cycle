class Movie < ActiveRecord::Base
    def others_by_same_director(director)
        Movie.where(director: director)
    end
end
