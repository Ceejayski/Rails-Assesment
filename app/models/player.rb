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
end
