# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_collab_session',
  :secret      => 'bae3c8270cc7ea60f86949290218ac4912db86f6f915babc14216e4f3e206a28854e72aae7ae28c5d36e74d1554e4159bfb94ec2669d924ad7192b85da6956cc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
