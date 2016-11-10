class SubscribeUserToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    gibbon = Gibbon::Request.new
    lower_md5_hashed_email = Digest::MD5.hexdigest(user.email.downcase)
    begin
      gibbon.lists(ENV['MAILCHIMP_LIST_KEY']).members(lower_md5_hashed_email).upsert(body: { email_address: user.email, status: "subscribed", merge_fields: { FNAME: user.first_name, LNAME: user.last_name }})
    rescue Exception => e
      logger.info e.message
    end
  end
end
