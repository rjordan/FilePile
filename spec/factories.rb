FactoryGirl.define do
  factory :file_document do
    sequence(:file_name) {|n| "Document#{n}" }
  end
end
