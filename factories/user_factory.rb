require 'factory_girl'


Factory.define :user do |f|
  f.sequence(:email) { |n| "email_#{n}@localhost.com" }
  f.sequence(:password) { |n| "password#{n}" }
  f.sequence(:short_name) { |n| "short_#{n}" }
end