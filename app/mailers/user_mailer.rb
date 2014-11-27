class UserMailer < ActionMailer::Base
  default from: ENV["GMAIL_EMAIL"]

  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Christmas Name Draw 2014")
  end
end