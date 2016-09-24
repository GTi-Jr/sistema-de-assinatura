class Address < ActiveRecord::Base
  belongs_to :user

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
    def only_one_main_address_per_user
      if (Address.where(user_id: user_id, main: true).count > User.class_variable_get(:@@max_addresses_number))
        errors.add(:main, 'Apenas um endereço principal por pessoa.')
      end
    end
end
