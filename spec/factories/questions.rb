FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyBody" }
    user

    trait :invalid do
      title { nil }
    end

    trait :with_files do
      after :create do |question|
        file_path1 = Rails.root.join('spec', 'suppor', 'assets', "image1.png")
        file_path2 = Rails.root.join('spec', 'suppor', 'assets', "image2.png")

        file1 = fixture_file_upload(file_path1, "image/png")
        file2 = fixture_file_upload(file_path2, "image/png")

        question.files.attach(file1, file2)
      end
    end
  end
end
