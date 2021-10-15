class Movie < ActiveRecord::Base
    # def self.with_director(director_name)  # class method
    #     self.where(director: director_name)
    # end
    
    def others_by_same_director
        # Movie.where(director: self.director).where.not(title: self.title)
        # Movie.where("director = :director AND title <> :title", {director: self.director, title: self.title})
        Movie.where("director = ? AND title <> ?", self.director, self.title)
    end
    
end
