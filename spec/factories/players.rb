# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :player do
    first_name { Faker::Name }
    last_name { Faker::Name }
    number { (0..99).to_a.sample }
    image { Faker::LoremPixel.image }
  end
end
