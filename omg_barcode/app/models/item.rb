# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  upc        :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ApplicationRecord
  validates :name, :upc, presence: true, uniqueness: true
  validates :upc, length: { is: 12 }
end
