require 'spec_helper'

describe AdvertiseWithUsController do

  describe "GET 'create_user'" do
    it "returns http success" do
      get 'create_user'
      response.should be_success
    end
  end

  describe "GET 'create_profile'" do
    it "returns http success" do
      get 'create_profile'
      response.should be_success
    end
  end

  describe "GET 'create_account'" do
    it "returns http success" do
      get 'create_account'
      response.should be_success
    end
  end

end
