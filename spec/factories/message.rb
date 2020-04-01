FactoryGirl.define do
 factory :message do
   body    {FFaker::Lorem.sentence}
   user
 end
end