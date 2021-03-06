Rails.application.routes.draw do

	get 'intranet' => 'intranet#intranet'
	get 'intranet' => 'intranet#intranet', as: 'user_root'

	resources :editions, only: [:show] do

		resources :participants, only: [:index, :show], param: :username
		get 'hall_of_fame' => 'participants#hall_of_fame'
		get 'organizer_of_fame' => 'participants#organizer_of_fame'

		resources :activities, only: [:index, :show] do
			post :register, on: :member
			delete :deregister, on: :member
		end

		resources :badges, only: [:index, :show] do
			get :redeem, on: :collection, action: :require, as: 'redeem'
			post :redeem, on: :collection, action: :redeem, as: 'redeem_post'
			get 'redeem/:code', on: :collection, action: :redeem, as: 'redeem_get'
		end
	end

	devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
	root to: 'intranet#intranet'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
