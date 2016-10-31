class Baby < ActiveRecord::Base
  belongs_to :subscription

  validates_presence_of :name

  def belongs_to?(user)
    subscription.user_id == user.id
  end
end
