Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :doctors
  resources :hospitals

  delete '/patient_doctors', to: 'patient_doctors#destroy'

end
