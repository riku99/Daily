class AddTitleToDiary < ActiveRecord::Migration[6.0]
  def change
    add_column :diaries, :title, :string
  end
end
