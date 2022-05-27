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
class Player < ApplicationRecord
  # validations
  validates_presence_of :last_name
  validates :number, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/jpg']

  # associations
  has_one_attached :image

  # scopes
  scope :latest, -> { order('created_at DESC') }

  # instance methods

  def image_url
    image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) : ''
  end
end
