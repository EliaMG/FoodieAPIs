Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  %w(seattle chicago boston austin louisville).each do |city|
    get '/' + city => 'apis#' + city
  end
end
