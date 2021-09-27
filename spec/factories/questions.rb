FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyBody" }
    user

    trait :invalid do
      title { nil }
    end
  end
end
