class Email < ActiveRecord::Base
  enum to: { everyone: 0, signing_users: 1, unsigning_users: 2  }

  attr_accessor :recipients

  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :to

  after_create :send_email

  private
    def send_email
      @recipients = set_recipient_through_to_field

      @recipients.each do |u|
        Mailsender.custom_email(u, title, body).deliver_now
      end
    end

    def set_recipient_through_to_field
      case to.to_sym
      when :everyone
        User.all
      when :signing_users
        User.where.not(subscription: nil)
      when :unsigning_users
        User.where(subscription: nil)
      end
    end
end
