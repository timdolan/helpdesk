class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :employee_number
      t.string :email
      t.string :work_phone
      t.string :cell_phone
      t.boolean :worker, :default => false
      t.boolean :admin, :default => false
      t.string :encrypted_password
      t.string :salt
      t.integer :location_id

      t.timestamps
    end
    
    add_index :users, :last_name
    add_index :users, :employee_number, :unique => true
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
