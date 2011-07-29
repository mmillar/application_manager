class CreateProfiles < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :profiles do |t|
        t.string :first_name
        t.string :last_name
        t.string :email
        t.string :phone, :limit => 40
        t.string :district, :limit => 500
        t.text :qualifications
        t.text :experience
        t.string :facebook_url
        t.integer :facebook_no_of_friends
        t.string :twitter_url
        t.integer :twitter_no_of_followers
        t.text :content_sample
        t.text :editorial_ideas
        t.string :key_issue_1
        t.string :key_issue_2
        t.string :key_issue_3
        t.string :media_formats
        t.string :equipment_access
        t.string :conflict_of_interest, :limit => 1000
        t.string :other_comments, :limit => 1000
        t.boolean :accepted_tos
        t.timestamps
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :profiles
    end
  end
end
