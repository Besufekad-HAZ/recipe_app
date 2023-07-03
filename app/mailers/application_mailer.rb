# frozen_string_literal: true

# The ApplicationMailer class is the base mailer class that other mailers in the application inherit from.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
