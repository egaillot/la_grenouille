# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_grenouille_session',
  :secret      => '5309cad95c163c3f9f090cdc4d7475097d8f9eac5742408020b1e88a30c2d9e88ee7105cc5d86bb93c8efe644e2bdbaa4fe50eecb559fd4c3b4e269c7cd3c99a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
