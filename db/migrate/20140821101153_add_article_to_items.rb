class AddArticleToItems < ActiveRecord::Migration
  def change
    add_column :items, :article, :string
  end
end
