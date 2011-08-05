class ProfileMailer < ActionMailer::Base
  #TODO change this to whatever suits the project
  default :from => "support@verto.ca"

  def initial_application(profile)
    @profile = profile
    mail(:to => "spejic@verto.ca", :subject => "Application received")
  end

  def thank_you(profile)
    @profile = profile
    mail(:to => profile.email, :subject => "Confirmation of application")
  end

  def acceptance_notification(profile)
    @profile = profile
    mail(:to => profile.email, :subject => "You've been selected as a Community Correspondent")
  end
end
