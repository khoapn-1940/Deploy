require "rails_helper"
#Carrierwave Test
#Enum Test
RSpec.describe User, type: :model do
  context "have many relation" do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:reviews) }
    it { should have_many(:ratings) }
    it { should have_many(:tours) }
    it { should have_many(:tour_details) }
    it { should have_many(:bookings) }
  end

  context "scope" do
    it "order by descending created_time" do
      user_one = create(:user)
      user_two = create(:user)
      user_three = create(:user)
      expect(User.order_by_time_desc).to match_array([user_three, user_two, user_one])
    end
  end

  context "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(Settings.name_maximum_length) }
    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:phone).is_at_least(Settings.phone_minimum_length).is_at_most(Settings.phone_maximum_length) }
    #Regex Phone
    it { should validate_presence_of(:bank_account) }
    it { should validate_length_of(:bank_account).is_at_least(Settings.bank_account_minimum_length).is_at_most(Settings.bank_account_maximum_length) }
    #Regex Bank Account
  end

  auth_hash = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '1234',
    :info => {
      :email => "user@example.com",
      :name => "Justin Bieber"
    }
  })
  
  describe User, "#from_omniauth" do
      it "retrieves an existing user" do
          user = User.new(
              provider: "facebook", 
              uid: 1234,
              email: "user@example.com",
              password: 'password', 
              password_confirmation: 'password'
              )
          user.save
          omniauth_user = User.from_omniauth(auth_hash)
          expect(user.email).to eq(omniauth_user.email)
    end
  end
end
