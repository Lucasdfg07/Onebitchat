FactoryGirl.define do
 factory :team do
   slug    {FFaker::Lorem.word}
   user
 end
end