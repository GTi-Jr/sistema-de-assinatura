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

  private
    def update_main_address_after_destroy
      other_user_addresses = Address.where(user_id: user_id).where.not(id: id)
      if other_user_addresses.count > 0
        other_user_addresses.first.update(main: true)
      else
        false
      end
    end
end
