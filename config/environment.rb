# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ApplicationManager::Application.initialize!

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t -f help@themarknews.com'
}