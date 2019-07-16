require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do
  before(:each) do
    create(:user)
    create(:user)
    create(:user)
    create(:user)
    assign(:users, User.unscoped.order_by_time_desc.page(params[:page]).per(
      Settings.user_per_page
    )
    )
  end

  it "renders a list of users" do
    render
    assert_select "h4", count:4
  end
end
