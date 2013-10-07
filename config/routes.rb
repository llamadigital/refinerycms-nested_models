Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :nested_models, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :nested_models, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
