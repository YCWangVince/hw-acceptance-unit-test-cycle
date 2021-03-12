class Movie < ActiveRecord::Base
    def self.all_ratings
    %w(G PG PG-13 NC-17 R)
    end
    # def self.with_ratings(ratings_list)
    #     if ratings_list.nil? or ratings_list.empty?
    #       return self.all
    #     end
    #     where({rating: ratings_list})
    # end
    def others_by_same_director(director)
        Movie.where(director: director)
    end
end
