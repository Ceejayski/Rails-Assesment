# frozen_string_literal: true

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
include ActionDispatch::TestProcess
FactoryBot.define do
  factory :player do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    number { Faker::Number.between(from: 0, to: 99) }
    image { Rack::Test::UploadedFile.new('spec/fixtures/sample.jpg', 'image/jpg') }
  end
end
