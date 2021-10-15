require 'rails_helper'
require 'simplecov'
SimpleCov.start 'rails'
# Rails.application.load_seed
# ActiveRecord::Base.subclasses.each(&:delete_all)



describe MoviesController, :type => :controller do
  
  
  describe 'When the specified movie has a director' do
    
    let!(:mov_1) { Movie.create!({:title => "Star Wars", :director => "George Lucas"}) }
    let!(:mov_2) { Movie.create!({:title => "THX-1138", :director => "George Lucas"}) }
    
    it 'should call the model method that performs the search' do
      expect_any_instance_of(Movie).to receive(:others_by_same_director)
      get :search, {:id => mov_1 }
    end
    
    
    it 'should select the template for rendering' do
      # Movie.any_instance.stub(:others_by_same_director).and_return([mov_2])
      get :search, {:id => mov_1.id }
      expect(response).to render_template('search')
    end
    
    
    it 'should make the results available to the template' do
      # Movie.any_instance.stub(:others_by_same_director).and_return([mov_2])
      get :search, {:id => mov_1.id }
      expect(assigns(:movies)).to eq([mov_2])
    end
    
  end
  
  describe 'When the specified movie does not have a director' do
  
    let!(:mov_3) { Movie.create!({:title => "Alien"}) }
  
    it 'should flash "has no director info"' do
      get :search, {:id => mov_3.id }
      # expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/'(.*)' has no director info/)
      
    end
    
    it 'should redirect to the homepage' do
      Movie.any_instance.stub(:others_by_same_director).and_return([])
      get :search, {:id => mov_3.id }
      expect(response).to redirect_to movies_path
      
    end
  
  end
  # ===================================================================
  
  describe 'when a movie is created' do
    it "should create the movie" do
      expect{post :create, {:movie => {title: "test1", director: "test2"}}}.to change{Movie.count}
      # expect(assigns(:movie)).to be_present(Movie.all)
    end
    
    it "should set @movie to created movie" do
      post :create, {:movie => {title: "test22", director: "test2"}}
      expect(assigns(:movie)).to eq(Movie.find_by_title("test22"))
      
    end
    
    it "should set set flash to 'was successfully created.'" do
      post :create, {:movie => {title: "test3", director: "test2"}}
      expect(flash[:notice]).to match(/(.*) was successfully created./)
    end
    
    it "should redirect back to movies page" do
      post :create, {:movie => {title: "test4", director: "test2"}}
      expect(response).to redirect_to movies_path
    end
    
  end
  
  describe 'when a movie is destroyed' do
    let!(:mov_4) { Movie.create!({:id => "1123", :title => "Alien"}) }
    
    it "should destroy the movie" do
      expect{post :destroy, {:id => mov_4.id}}.to change{Movie.count}.by(-1)
    end
    
    it "should set set flash to 'Movie '(.*)' deleted.'" do
      post :destroy, {:id => mov_4.id}
      expect(flash[:notice]).to match(/Movie '(.*)' deleted./)
    end
    
    it "should redirect back to movies page" do
      post :destroy, {:id => mov_4.id}
      expect(response).to redirect_to movies_path
    end
  end
  
  
  describe 'when a movie is edited' do
    let!(:mov) { Movie.create!({:title => "Alien123"}) }
    it 'should set render param @movie to edited movie' do
      get :edit, {:id => mov.id}
      expect(assigns(:movie)).to eq(mov)
    end
  end
  
  describe 'movie show' do
    let!(:mov) { Movie.create!({:title => "Alien123"}) }
    it 'should set @movie' do
      get :show, {:id => mov.id}
      expect(assigns(:movie)).to eq(mov)
    end
  end
  
  
end


Movie.all.each do |movie|
    Movie.destroy(movie.id)
end
