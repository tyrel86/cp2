require 'spec_helper'

describe "user_profiles/show" do
  before(:each) do
    @user_profile = assign(:user_profile, stub_model(UserProfile))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
