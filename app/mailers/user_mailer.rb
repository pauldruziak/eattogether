class UserMailer < ActionMailer::Base
  default from: 'noreply@eattogetherapp.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('devise.mailer.signed_up'))
  end
end
