Rails.application.routes.draw do
  # Root route
  root 'transactions#upload_form'

  get 'upload_form', to: 'transactions#upload_form', as: :upload_form

  # Transactions routes
  resources :transactions, only: [:index] do
    collection do
      post :upload_form
      post :upload
    end
  end
end
