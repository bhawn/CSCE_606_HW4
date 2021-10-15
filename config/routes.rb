Rottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  match '/movies/director/:id', to: 'movies#search', as: :search_directors, via: :get
end
# <%= link_to 'Find Movies With Same Director', search_directors_path(@movie), :class => 'btn btn-primary col-2' %>
  