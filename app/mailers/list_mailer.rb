class ListMailer < ActionMailer::Base
  default from: ENV["GMAIL_EMAIL"]

  def paired(user)
    @user = user
    @paired_user = user.paired_user
    mail(to: user.email, subject: "Christmas Name Draw - You've Been Paired!")
  end
end