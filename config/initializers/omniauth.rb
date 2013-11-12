OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'bR0gj0CVPunaH5QWe3RSQ', 'sm1Ny5HaWTqyfGmWjTPmrJW6Q4sTdO778MrwlbPVAAo'
  provider :facebook, ENV[ '751704818177829' ], ENV[ '83e4bea2211297a1972cf18efdfea1bb' ]
  provider :google_oauth2, '511966716965.apps.googleusercontent.com', 'biweyHE4BXBTpqqqlD6FMPBX'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end