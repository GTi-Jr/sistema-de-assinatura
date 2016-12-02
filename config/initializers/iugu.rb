if Rails.env.development?
  Iugu.api_key = "785e67786725d85fa8a5b9b2974ca12d"
else
  Iugu.api_key = ENV['IUGU_API_KEY']
end
