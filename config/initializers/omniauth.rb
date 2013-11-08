Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'bR0gj0CVPunaH5QWe3RSQ', 'sm1Ny5HaWTqyfGmWjTPmrJW6Q4sTdO778MrwlbPVAAo'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end