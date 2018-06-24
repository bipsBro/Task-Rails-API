Rails.application.routes.draw do
  devise_for :users
  devise_for :models
  get 'leave/create'
  namespace 'api' do
		namespace 'v1' do
			resources :leaves
		end
	end
  # resources :leave do
  # 		resources :user
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
