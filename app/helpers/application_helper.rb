module ApplicationHelper
  def pair_name(user)
    if user.paired_user
      user.paired_list.user.first_name
    else
      "Pair"
    end
  end
end
