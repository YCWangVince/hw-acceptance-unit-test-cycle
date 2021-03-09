Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get 'similardirector/:id', to: 'movies#similardirector', as: 'similardirector_movie'
end
