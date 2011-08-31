class ProfileMailer < ActionMailer::Base
  #TODO change this to whatever suits the project
  default :from => "\"Application Support\" <help@themarknews.com>"

  def initial_application(profile)
    @profile = profile
    mail(:to => "help@themarknews.com", :subject => "Application received")
  end

  def thank_you(profile)
    @profile = profile
    mail(:to => profile.email, :bcc => "help@themarknews.com", :subject => "Confirmation of application")
  end

  def acceptance_notification(profile)
    @profile = profile
    mail(:to => profile.email, :bcc => "help@themarknews.com", :subject => "You've been selected as a Community Correspondent")
  end
end
