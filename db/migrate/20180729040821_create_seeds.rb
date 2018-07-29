class CreateSeeds < ActiveRecord::Migration
  def change
    create_table :seed do |t|
      t.string :name
      t.string :type
      t.string :description
  end
end
