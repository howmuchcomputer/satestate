Rails.application.routes.draw do
  root 'satellite#health'

  get 'satellite/health'
  get 'satellite/stats'
end
