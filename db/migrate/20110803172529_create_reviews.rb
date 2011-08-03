class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.boolean :qualified
      t.boolean :approved
      t.boolean :bio_edited, :default => false
      t.boolean :photo_edited, :default => false
      t.datetime :offer_sent
      t.datetime :offer_accepted

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
