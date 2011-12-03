class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :title
      t.text :issue
      t.string :ticket_type
      t.string :priority
      t.string :urgency
      t.string :impact
      t.string :status
      t.string :resolution
      t.text :resolution_explanation
      t.integer :location_id
      t.integer :contact
      t.integer :assigned_to

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
