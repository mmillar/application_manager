class AddProfileToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :profile_id, :integer
  end

  def self.down
    remove_column :reviews, :profile_id
  end
end
