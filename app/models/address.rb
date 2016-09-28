class Address < ActiveRecord::Base
  belongs_to :user

  before_destroy :update_main_address_after_destroy

  validates_presence_of :street
  validates_presence_of :zipcode
  validates_presence_of :number
  validates_presence_of :city
  validates_presence_of :state

  def main?
    main
  end

  def become_main
    Address.where(user: user).where.not(id: id).update_all(main: false)
    update(main: true)
  end

  def last_user_address?
    !Address.where(user: user).where.not(id: id).any?
  end

  private
    def update_main_address_after_destroy
      if last_user_address?
        false
      else
        Address.where(user_id: user_id).where.not(id: id).first.update(main: true)
      end
    end
end
