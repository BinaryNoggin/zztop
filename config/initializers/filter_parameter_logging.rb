# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]
    Rails.application.config.filter_parameters += [:password_confirmation, :confirm_password]
    Rails.application.config.filter_parameters += [:ssn, :social_security_number]
    Rails.application.config.filter_parameters += [:credit_card, :credit_card_number, :cvv, :cvv2]
