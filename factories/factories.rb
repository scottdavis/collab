require 'factory_girl'
require 'faker'

Factory.define :user do |f|
  f.sequence(:email) { |n| "email_#{n}@localhost.com" }
  f.sequence(:password) { |n| "password#{n}" }
  f.sequence(:short_name) { |n| "short_#{n}" }
end

Factory.define :project do |f|
  f.sequence(:name) {|n| "project #{n}"}
end

Factory.define :task do |f|
  f.sequence(:name) {|n| "task #{n}"}
  f.sequence(:description) {|n| "This is a task #{n}"}
end

Factory.define :wall do |f|
  f.text "@short_2 This is a wall post of fun and goodness"
end