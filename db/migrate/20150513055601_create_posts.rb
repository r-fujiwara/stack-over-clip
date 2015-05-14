class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.integer :user_id
      t.text :url
      t.text :content

      t.timestamps null: false
    end
  end
end
