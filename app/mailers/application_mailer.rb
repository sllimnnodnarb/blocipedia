class ApplicationMailer < ActionMailer::Base
  default from: 'sllimnodnarb@gmail.com'
  layout 'mailer'

  def mailout
    mail(to: User.first, subject: "Blocipedia")
  end
end
