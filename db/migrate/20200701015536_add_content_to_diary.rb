class AddContentToDiary < ActiveRecord::Migration[6.0]
  def change
    add_column :diaries, :content, :string
  end
end
