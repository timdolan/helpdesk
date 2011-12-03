class CreateTicketComments < ActiveRecord::Migration
  def self.up
    create_table :ticket_comments do |t|
      t.text :comment
      t.string :status
      t.integer :ticket_id
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_comments
  end
end
