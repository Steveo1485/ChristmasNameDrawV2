namespace :lists do

  desc "Send updated list email"
  task :updated_email => :environment do
    p "Fetching lists."
    lists = List.where("updated_at > ?", 1.day.ago)
    lists.each do |list|
      ListMailer.updated_list(list).deliver
    end
    p "Updated list emails sent!"
  end
end