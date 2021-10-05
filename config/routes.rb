Rails.application.routes.draw do
  get "/movies" => "movies#index"
  get "/movies/:id"=> "movies#show", as:"movie"
  root "movies#index"
  # get "/" => "movies#index", Kan også gjøre slik#
end
