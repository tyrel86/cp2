require 'spec_helper'

describe UserDispensaryReviewsController do

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'user_index'" do
    it "returns http success" do
      get 'user_index'
      response.should be_success
    end
  end

end
