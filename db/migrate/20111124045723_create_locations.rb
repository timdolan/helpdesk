class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.integer :user_id

      t.timestamps
    end
    
    add_index :locations, :name
  end

  def self.down
    drop_table :locations
  end
end
