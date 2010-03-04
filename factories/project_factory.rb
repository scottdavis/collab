require 'factory_girl'

Factory.define :project do |f|
  f.sequence(:name) {|n| "project #{n}"}
end