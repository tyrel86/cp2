require 'spec_helper'

describe "user_profiles/edit" do
  before(:each) do
    @user_profile = assign(:user_profile, stub_model(UserProfile))
  end

  it "renders the edit user_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_profiles_path(@user_profile), :method => "post" do
    end
  end
end
