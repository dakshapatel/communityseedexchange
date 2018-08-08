class AddCloumnToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :user_id, :integer
    add_column :seeds, :availability, :string
    add_column :seeds, :location, :string
  end
end
