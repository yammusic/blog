require 'omniauth-openid'
require 'openid/store/filesystem'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'bR0gj0CVPunaH5QWe3RSQ', 'sm1Ny5HaWTqyfGmWjTPmrJW6Q4sTdO778MrwlbPVAAo'
  provider :facebook, '255795097902426', 'c764fd286001d015e5f2521ece687ff7'
  provider :google_oauth2, '511966716965.apps.googleusercontent.com', 'biweyHE4BXBTpqqqlD6FMPBX'
  provider :linked_in, '75p9933xcr1yi9', 'iLCKAfAssOerNuwt'
  provider :yahoo, 'dj0yJmk9a1QxVGtrcmpTTHJHJmQ9WVdrOU9HcGFRVVprTm5VbWNHbzlNVFE1TlRVd09EYzJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD0yOQ--', 'a75f1eb89aade6f27c6ff212f763e49e96baccb9'
  provider :open_id, :store => OpenID::Store::Filesystem.new( '/tmp' )
  provider :open_id, :name => 'google', :identifier => '/auth/google'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end