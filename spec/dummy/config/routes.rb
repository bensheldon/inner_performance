Rails.application.routes.draw do
  mount InnerPerformance::Engine => "/performance"

  get :dummy, controller: :application
end
