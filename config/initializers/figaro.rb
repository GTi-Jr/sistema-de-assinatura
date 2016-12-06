keys = []
keys.push('SENDGRID_USERNAME') if Rails.env.production?
keys.push('SENDGRID_PASSWORD') if Rails.env.production?
#keys.push('IUGU_API_KEY')
keys.push('IUGU_WEBHOOK_KEY')

Figaro.require_keys(keys)
