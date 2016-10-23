class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def voice
    user = User.find(params[:user_id])
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there, #{user.first_name}.', :voice => 'alice'
    end

    render_twiml response
  end
end
