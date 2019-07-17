class Category < ApplicationRecord
  acts_as_paranoid
  has_many :tours, dependent: :destroy
  scope :order_by_time_desc, ->{order(created_at: :desc)}
  validates :name, presence: true,
  length: {maximum: Settings.name_maximum_length}
  validates :description, presence: true,
  length: {maximum: Settings.description_maximum_length}
end
