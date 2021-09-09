Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


 root to: "admin/dashboard#index"
# get 'payment_datum/import', :to => 'payment_datum#import'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
