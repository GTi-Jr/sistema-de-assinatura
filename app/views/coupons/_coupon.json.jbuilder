json.extract! coupon, :id, :code, :amount, :quantity, :expiry_date, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)