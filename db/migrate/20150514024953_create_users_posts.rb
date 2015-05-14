class CreateUsersPosts < ActiveRecord::Migration
  def change
    create_table :users_posts do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end

    add_index :users_posts, :user_id
    add_index :users_posts, :post_id
  end
end
