FactoryBot.define do
  factory :comment do
    body { "My comment" }
    commentable
    user
  end
end
