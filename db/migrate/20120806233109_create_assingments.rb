class CreateAssingments < ActiveRecord::Migration
  def change
    create_table :assingments do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
