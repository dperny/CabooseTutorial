CabooseTutorial::Application.routes.draw do

  # Routes for Blog Posts
  get "blog_post/:id" =>  "blog_post#show"
  get "blog_post/new" => "blog_post#new"
  post "blog_post" => "blog_post#create"
  get "blog_post/:id/edit" => "blog_post#edit"
  put "blog_post/:id" => "blog_post#update"
  delete "blog_post/:id" => "blog_post#delete"

  # Catch everything with Caboose
  mount Caboose::Engine => '/'
  match '*path' => 'caboose/pages#show'
end
