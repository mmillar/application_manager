class ProfileMailer < ActionMailer::Base
  #TODO change this to whatever suits the project
  default :from => "support@verto.ca"
  default :to => 

  def initial_application(profile)
    @profile = profile
    mail(:to => "editor@themarknews.com", :subject => "Application received")
  end

  def thank_you(profile)
    @profile = profile
    mail(:to => profile.email, :subject => "Confirmation of application")
  end
end