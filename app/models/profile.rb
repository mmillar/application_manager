class Profile < ActiveRecord::Base
  attr_accessor :confirm_email

  attr_accessible :first_name, :last_name, :email, :phone, :district, :qualifications, :experience, :facebook_url, :facebook_no_of_friends, :twitter_url, :twitter_no_of_followers, :content_sample, :editorial_ideas, :key_issue_1, :key_issue_2, :key_issue_3, :media_formats, :equipment_access, :conflict_of_interest, :other_comments, :accepted_tos, :confirm_email

  validates_presence_of :first_name, :last_name, :email, :phone, :district, :qualifications, :experience, :facebook_url, :facebook_no_of_friends, :twitter_url, :twitter_no_of_followers, :content_sample, :editorial_ideas, :key_issue_1, :key_issue_2, :key_issue_3, :conflict_of_interest, :other_comments, :accepted_tos

  validates_numericality_of :facebook_no_of_friends, :twitter_no_of_followers
  validate :email_matches_its_confirmation

  def convert(field_to_convert, value_arr)
    self.send("#{field_to_convert}=", value_arr.reject(&:blank?).join(","))
  end
  private
  def email_matches_its_confirmation
    errors.add(:confirm_email, "doesn't match e-mail address") if email != confirm_email
  end
end
