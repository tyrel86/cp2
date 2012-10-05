class AddPhoneNumberAndAddressToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :phone_number, :string
    add_column :user_profiles, :address, :string
  end
end
