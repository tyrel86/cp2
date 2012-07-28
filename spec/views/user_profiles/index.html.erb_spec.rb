require 'spec_helper'

describe "user_profiles/index" do
  before(:each) do
    assign(:user_profiles, [
      stub_model(UserProfile),
      stub_model(UserProfile)
    ])
  end

  it "renders a list of user_profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
