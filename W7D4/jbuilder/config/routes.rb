Rails.application.routes.draw do
 namespace :api, defaults: {format: :json} do
   resources :gifts
   resources :guests do
     resources :gifts
   end
   resources :invitations
   resources :parties
 end
end
