class AddFieldsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :coupon_type , :string
  end
end
