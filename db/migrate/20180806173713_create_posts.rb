class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :seed, index: true
      t.string :comments
    end
  end
end
