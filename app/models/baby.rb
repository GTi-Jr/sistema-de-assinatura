class Baby < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name

  def  belongs_to?(user)
    user_id == user.id
  end
end
