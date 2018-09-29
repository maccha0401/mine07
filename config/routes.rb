Rails.application.routes.draw do
  # ■root
  root to: "tweets#index"

  # ■tweet
  resources :tweets do
    collection do
      post :confirm
    end
  end
end
