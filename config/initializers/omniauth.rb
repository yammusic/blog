OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'bR0gj0CVPunaH5QWe3RSQ', 'sm1Ny5HaWTqyfGmWjTPmrJW6Q4sTdO778MrwlbPVAAo'
  provider :facebook, '255795097902426', 'c764fd286001d015e5f2521ece687ff7'
  provider :google_oauth2, '511966716965.apps.googleusercontent.com', 'biweyHE4BXBTpqqqlD6FMPBX'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end