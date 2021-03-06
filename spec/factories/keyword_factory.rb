# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  word       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :keyword do
    word { Faker::Hipster.words(1).first }
  end
end
