class Review < ActiveRecord::Base

  belongs_to :profile
  
  def status
    if self.qualified.nil?
      return "Unreviewed"
    elsif !self.qualified
      return "Rejected"
    elsif self.bio_edited && self.photo_edited
      return "Completed"
    elsif self.offer_accepted != nil
      unless self.profile.bio.nil? || self.profile.picture.nil?
        return "User Profile Uploaded"
      end
      return "Offer Accepted"
    elsif self.offer_sent != nil
      return "Offered"
    elsif self.approved
      return "Approved"
    elsif self.qualified
      return "Scored"
    end
  end
end
