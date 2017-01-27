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
  validates :upc, numericality: {greater_than_or_equal_to: 10000000000,
                                 less_than_or_equal_to: 99999999999}
end
