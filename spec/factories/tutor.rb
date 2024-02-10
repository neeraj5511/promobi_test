FactoryBot.define do
  factory :tutor do
    name { 'John' }
    age { 30 }
    experience { 3 }
    association :course
  end
end
