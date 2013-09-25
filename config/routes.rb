Fachbereichsduell::Application.routes.draw do
  get "presentation/index"
  get "presentation/view_state"
  get "presentation/guessing"
  get "presentation/guessing_with_choices"
  get "presentation/starting"
  get "presentation/points_and_xes"
  get "presentation/round"
  get "presentation/game_over"
  get "presentation/showing_question"
  get "presentation/showing_answers"
  get "presentation/answer_state/:id" => "presentation#answer_state"
  get "presentation/president_answers"

  get "admin/index"
  post "admin/change_state"
  post "admin/assign_answer"
  post "admin/remove_answer"
  post "admin/add_x"
  post "admin/next_question"
  post "admin/remove_estimation_answer"
  post "admin/accept_president_answer"

  root to: "questions#show"

  get "questions/show"

  get "questions/reload_check"

  post "questions/submit_answer"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  
  # root :to => 'questions#show'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
