class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :title
      t.string :content
      t.integer :priority

      t.timestamps
    end
  end
end
