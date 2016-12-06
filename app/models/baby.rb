class Baby < ActiveRecord::Base
  belongs_to :subscription

  def belongs_to?(user)
    subscription.user_id == user.id
  end

  def age
    unless birthdate.blank?
      now = Date.today
      now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end
end
