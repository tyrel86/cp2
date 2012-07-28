require 'spec_helper'

describe "user_profiles/new" do
  before(:each) do
    assign(:user_profile, stub_model(UserProfile).as_new_record)
  end

  it "renders new user_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_profiles_path, :method => "post" do
    end
  end
end
