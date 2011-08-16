class Profile < ActiveRecord::Base
  attr_accessor :confirm_email, :bypass
  before_create :generate_token
  
  has_one :review, :dependent => :destroy
  attr_accessible :first_name, :last_name, :email, :phone, :district, :experience, :facebook_url, :facebook_no_of_friends, :twitter_url, :twitter_no_of_followers, :content_sample, :editorial_ideas, :key_issue_1, :key_issue_2, :key_issue_3, :media_formats, :equipment_access, :conflict_of_interest, :other_comments, :confirm_email, :bio, :picture, :bypass

  mount_uploader :picture, PictureUploader
  validates_presence_of :first_name, :last_name, :email, :phone, :district, :experience, :facebook_url, :facebook_no_of_friends, :twitter_url, :twitter_no_of_followers, :content_sample, :editorial_ideas, :key_issue_1, :key_issue_2, :key_issue_3, :conflict_of_interest, :other_comments

  validates_numericality_of :facebook_no_of_friends, :twitter_no_of_followers
  validates_format_of :phone, :with => /\d*\-*\(*\d{3}\-*\)*\s*\d{3}\-*\d{4}\s?(x|ext\.\s)?\d{0,5}/
  validates_email_format_of :email
  validates_format_of :facebook_url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates_format_of :twitter_url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validate :email_matches_its_confirmation, :bio_is_present, :picture_is_present
  
  DISTRICTS = ["Ajax-Pickering","Algoma-Manitoulin","Ancaster-Dundas-Flamborough-Westdale","Barrie","Beaches-East York","Bramalea-Gore-Malton","Brampton-Springdale","Brampton West","Brant","Bruce-Grey-Owen Sound","Burlington","Cambridge","Carleton-Mississippi Mills","Chatham-Kent-Essex","Davenport","Don Valley East","Don Valley West","Dufferin-Caledon","Durham","Eglinton-Lawrence","Elgin-Middlesex-London","Essex","Etobicoke-Centre","Etobicoke-Lakeshore","Etobicoke-North","Glengarry-Prescott-Russell","Guelph","Haldimand-Norfolk","Haliburton-Kawartha Lakes-Brock","Halton","Hamilton-Centre","Hamilton-East-Stoney Creek","Hamilton Mountain","Huron-Bruce","Kenora-Rainy River","Kingston and the Islands","Kitchener-Centre","Kitchener-Conestoga","Kitchener-Waterloo","Lambton-Kent-Middlesex","Lanark-Frontenac-Lennox and Addington","Leeds-Grenville","London-Fanshawe","London North Centre","London West","Markham-Unionville","Mississauga-Brampton South","Mississauga East-Cooksville","Mississauga-Erindale","Mississauga South","Mississauga-Streetsville","Nepean-Carleton","Newmarket-Aurora","Niagara Falls","Niagara West-Glanbrook","Nickel Belt","Nipissing","Northumberland-Quinte West","Oak Ridges-Markham","Oakville","Oshawa","Ottawa-Centre","Ottawa-Orleans","Ottawa South","Ottawa-Vanier","Ottawa West-Nepean","Oxford","Parkdale-High Park","Parry Sound-Muskoka","Perth-Wellington","Peterborough","Pickering-Scarborough East","Prince Edward-Hastings","Renfrew-Nipissing-Pembroke","Richmond Hill","St. Catharines","St. Paul's","Sarnia-Lambton","Sault Ste. Marie","Scarborough-Agincourt","Scarborough-Centre","Scarborough-Guildwood","Scarborough-Rouge River","Scarborough Southwest","Simcoe-Grey","Simcoe North","Stormont-Dundas-South Glengarry","Sudbury","Thornhill","Thunder Bay-Atikokan","Thunder Bay-Superior North","Timiskaming-Cochrane","Timmins- James Bay","Toronto-Centre","Toronto-Danforth","Trinity-Spadina","Vaughan","Welland","Wellington-Halton Hills","Whitby-Oshawa","Willowdale","Windsor-Tecumseh","Windsor West","York-Centre","York-Simcoe","York South-Weston","York West"]
  
  ISSUES = ["Government - Accountability","Government - Transportation","Crime - Illegal Tobacco / Drugs","Crime - Sex Offenders","Crime - Prison Labour","Economy - Public Tax Rates","Economy - Corporate Tax Rates","Economy - HST","Economy - Welfare","Economy - Unions","Economy - Deficit Reduction","Economy - Job Creation","Education - Kindergarten","Education - Primary / Secondary School","Education - Post Secondary School","Health Care - Wait Times","Health Care - Elder Care","Environmentalism - Power / Energy","Environmentalism - Wind Farms","Environmentalism - Nuclear Energy","Other"]
  
  STATUSES = ["Unscored","Rejected","Scored","The Star Approved","Offered","Accepted"]

  def convert(field_to_convert, value_arr)
    self.send("#{field_to_convert}=", value_arr.reject(&:blank?).join(","))
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private
  def email_matches_its_confirmation
    errors.add(:confirm_email, "doesn't match e-mail address") if id == nil && email != confirm_email
  end

  def bio_is_present
    errors.add(:bio, "can't be blank") if bio.blank? && !new_record? && !bypass
  end

  def picture_is_present
    errors.add(:picture, "must be uploaded") if picture.blank? && !new_record? && !bypass
  end

  def generate_token
    self.token = rand(48**12).to_s(36)
  end
end
