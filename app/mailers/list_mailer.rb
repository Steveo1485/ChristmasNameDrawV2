class ListMailer < ActionMailer::Base
  default from: ENV["GMAIL_EMAIL"]

  def paired
    User.all.each do |user|
      @user = user
      mail(to: user.email, subject: "Christmas Name Draw - You've Been Paired!")
    end
  end
end