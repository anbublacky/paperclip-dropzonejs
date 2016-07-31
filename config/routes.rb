DropzoneRails::Application.routes.draw do
  resources :musics

  root 'uploads#new'
  get '/render-progress-limit' => 'uploads#progress_limit'
  resources :uploads
end
