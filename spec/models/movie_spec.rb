require 'rails_helper'
require 'simplecov'
SimpleCov.start 'rails'




describe Movie do
    let!(:mov_1) { Movie.create!({:title => "Star Wars", :director => "George Lucas"}) }
    let!(:mov_2) { Movie.create!({:title => "THX-1138", :director => "George Lucas"}) }
    let!(:mov_3) { Movie.create!({:title => "Alien"}) }
    
    describe 'searching database by director' do
        context "Director exists" do 
            it 'should return the correct matches for movies by the same director' do
               expect(mov_1.others_by_same_director).to eq([mov_2])
            end
            
            it 'should not return matches of movies by different directors.' do
               expect(mov_1.others_by_same_director).to_not include([mov_3]) 
            end
            
        end
        
        context "Director does not exist" do 
            it 'should return empty array' do
               expect(mov_3.others_by_same_director).to eq([])
            end
        end
    end
end


# it should return the correct matches for movies by the same director and
# it should not return matches of movies by different directors.