class AddTitleBodyCategoryColumnsToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_reference :posts, :category, foreign_key: true
  end
end
