class ProfileMailer < ActionMailer::Base
  #TODO change this to whatever suits the project
  default :from => "\"Application Support\" <help@themarknews.com>", :bcc => "stephanie@themarknews.com"

  def initial_application(profile)
    @profile = profile
    mail(:to => "help@themarknews.com", :subject => "Application received")
  end

  def thank_you(profile)
    @profile = profile
    mail(:to => profile.email, :subject => "Confirmation of application")
  end

  def acceptance_notification(profile)
    @profile = profile
    mail(:to => profile.email, :subject => "You've been selected as a Community Blogger")
  end

  def acceptance_confirmation(profile)
    @profile = profile
    mail(:to => profile.email, :subject => "Participation confirmed")
  end
end
