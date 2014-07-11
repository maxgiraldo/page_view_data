CodingExercise::Application.routes.draw do
  root 'static_pages#index'

  namespace :api, defaults: {format: :json} do
    scope module: :v1 do
        get '/top_urls' => 'top_urls#index', :via => :get
        get '/top_referrers' => 'top_referrers#index', :via => :get
    end
  end

end
