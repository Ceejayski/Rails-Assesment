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
require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#Validations' do
    it { should validate_presence_of(:last_name) }
    it { should validate_numericality_of(:number).is_less_than_or_equal_to(99) }
    it { should validate_numericality_of(:number).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_content_type_of(:image).rejecting('text/plain', 'text/xml') }
  end

  describe '#Associations' do
    it { should have_one_attached(:image) }
  end
end
