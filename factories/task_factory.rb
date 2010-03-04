require 'factory_girl'
require 'faker'
Factory.define :task do |f|
  f.sequence(:name) {|n| "task #{n}"}
  f.description Faker::Lorem.paragraphs(1)
end
