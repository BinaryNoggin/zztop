PHONE_NUMBER = "+13142070404"
Twilio.configure do |config|
  config.account_sid = Rails.application.secrets.TWILIO_ACCOUNT_SID
  config.auth_token = Rails.application.secrets.TWILIO_AUTH_TOKEN
end
