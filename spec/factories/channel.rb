FactoryGirl.define do
 factory :channel do
   slug { FFaker::Lorem.word }
   team
   user { team.user }
 end
end