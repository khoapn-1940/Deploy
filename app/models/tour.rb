class Tour < ApplicationRecord
  acts_as_paranoid
  mount_uploader :image, TourUploader
  belongs_to :user
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :tour_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  scope :order_by_time_desc, ->{order(created_at: :desc)}
  validates :user_id, numericality:
   {greater_than_or_equal_to: Settings.positive}
  validates :category_id, numericality:
   {greater_than_or_equal_to: Settings.positive}
  validates :name, presence: true,
  length: {maximum: Settings.name_maximum_length}
  validates :description, presence: true,
  length: {maximum: Settings.description_maximum_length}
end
