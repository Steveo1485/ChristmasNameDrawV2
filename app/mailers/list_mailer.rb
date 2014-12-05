class ListMailer < ActionMailer::Base
  default from: ENV["GMAIL_EMAIL"]

  def paired(user)
    @user = user
    @paired_user = user.paired_user
    mail(to: user.email, subject: "Christmas Name Draw - You've Been Paired!")
  end

  def updated_list(list)
    @list = list
    @list_owner = list.user
    @paired_user = @list_owner.paired_user
    mail(to: @paired_user.email, subject: "#{@list_owner.first_name}'s List Has Been Updated!")
  end
end