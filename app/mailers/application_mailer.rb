class ApplicationMailer < ActionMailer::Base
  require "letter_opener"
  ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, :location => File.expand_path('../tmp/letter_opener', __FILE__)
  ActionMailer::Base.delivery_method = :letter_opener
  default from: 'priyanka.pakki@beautifulcode.in'
  layout 'mailer'

end
