require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { create(:user) }
  # let(:valid_attributes) { {name: "PhamNguyenKhoa"} }
  # let(:invalid_attributes) { {name: "a" * 256} }

  before(:example) do
    sign_in(create(:admin))
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    it "returns a success response" do
      new_role = "admin"
      put :update, params: {id: user.to_param, role: new_role}
      user.reload
      expect(user.role).to eq("admin")
    end
  end



  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = create(:user)
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = create(:user)
      delete :destroy, params: {id: user.to_param}
      expect(response).to redirect_to(admin_users_path)
    end
  end

  describe "GET #recover" do
    it "destroy and recover" do
      user = create(:user)
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
      expect {
        get "recover", params: {id: user.to_param}
      }.to change(User, :count).by(+1)
    end
  end
end
