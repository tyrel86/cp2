class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :body
      t.integer :order

      t.timestamps
    end
  end
end
