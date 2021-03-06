class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :article
      t.text :keyword
      t.boolean :current, :default => false
      t.boolean :public, :default => false
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
