class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :tours, dependent: :destroy
  has_many :tour_details, dependent: :destroy
  has_many :bookings, dependent: :destroy
  scope :order_by_time_desc, ->{order(created_at: :desc)}
  enum role: {guess: 0, user: 1, admin: 2}
  validates :name,  presence: true,
   length: {maximum: Settings.name_maximum_length}
  VALID_PHONE_REGEX = /\A[+-]?\d+\z/i
  validates :phone, presence: true,
   length:
  {
    minimum: Settings.phone_minimum_length,
    maximum: Settings.phone_maximum_length
  },
   format: {with: VALID_PHONE_REGEX}
  VALID_BANK_ACCOUNT_REGEX = /\A[+-]?\d+\z/i
  validates :bank_account, presence: true,
   length:
  {
    minimum: Settings.bank_account_minimum_length,
    maximum: Settings.bank_account_maximum_length
  },
   format: {with: VALID_BANK_ACCOUNT_REGEX}
  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end
end
