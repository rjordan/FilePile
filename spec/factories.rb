FactoryGirl.define do
  factory :file_document do
    sequence(:name) {|n| "Document#{n}" }
  end
end
