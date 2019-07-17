class Booking < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :tour_detail
  has_many :payments, dependent: :destroy
  scope :order_by_time_desc, ->{order(created_at: :desc)}
  scope :this_month, (lambda do
    where(
      created_at: Time.now.beginning_of_month..Time.now.end_of_month
    )
  end)
  validates :book_total, numericality:
    {
      greater_than_or_equal_to: Settings.positive,
      less_than_or_equal_to: Settings.maximum_book_total
    }
  validates :tour_detail_id, numericality:
    {greater_than_or_equal_to: Settings.positive}
end
