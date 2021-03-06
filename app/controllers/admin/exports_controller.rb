class Admin::ExportsController < ApplicationController
  before_filter :authenticate_user!
  layout :nothing => true

  def get_workbook
    workbook = Spreadsheet::Workbook.new
    sheet = workbook.create_worksheet
    
    hash_array = get_hash_array
    hash_array.each_with_index do |hash_row, row|
      hash_row.each_with_index do |(key, value), col|
        sheet[row,col] = key.dup.to_s if row == 0
        sheet[row+1,col] = value
      end
    end
    
    cur_time = Time.now.to_i.to_s
    
    blob = StringIO.new("")
    workbook.write blob
    
    respond_to do |format|
      format.xls { send_data blob.string , :filename => "profiles_export_"+cur_time+".xls", :type => "application/vnd.ms-excel" }
    end
  end
  
  def get_hash_array
    output = []
    
    profile_list = Profile.all
    
    profile_list.each do |profile|
      tmp_hash = Hash.new()
      tmp_hash["Id"] = profile.id
      tmp_hash["First"] = profile.first_name
      tmp_hash["Last"] = profile.last_name
      tmp_hash["Email"] = profile.email
      tmp_hash["Phone"] = profile.phone
      tmp_hash["District"] = profile.district
      #tmp_hash["Qualifications"] = profile.qualifications
      tmp_hash["Experience"] = profile.experience
      tmp_hash["Facebook URL"] = profile.facebook_url
      tmp_hash["Friends"] = profile.facebook_no_of_friends
      tmp_hash["Twitter URL"] = profile.twitter_url
      tmp_hash["Followers"] = profile.twitter_no_of_followers
      tmp_hash["Content Sample"] = profile.content_sample[0,1000]
      tmp_hash["Editorial Ideas"] = profile.editorial_ideas
      tmp_hash["Key Issue 1"] = profile.key_issue_1
      tmp_hash["Key Issue 2"] = profile.key_issue_2
      tmp_hash["Key Issue 3"] = profile.key_issue_3
      tmp_hash["Media Formats"] = profile.media_formats
      tmp_hash["Equipment Access"] = profile.equipment_access
      tmp_hash["Conflicts"] = profile.conflict_of_interest
      tmp_hash["Bio"] = profile.bio
      tmp_hash["Picture"] = "http://apply.speakyourmind.thestar.com#{profile.picture_url.to_s}"
      tmp_hash["Address"] = profile.address
      tmp_hash["City"] = profile.city
      tmp_hash["Postal Code"] = profile.postal_code
      tmp_hash["Status"] = profile.review.status
      
      output << tmp_hash
    end
    
    output
  end
end
