class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def respond_to_homeless_voice
    response = params[:Digits].to_i
    Twilio::TwiML::Response.new do |r|
      r.Say "Thanks for responding with #{response}, #{user.first_name}", :voice => 'alice'
    end


    render_twiml response
  end

  def voice
    Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: 1, action: twilio_respond_to_homeless_voice_url(user) do |g|
        g.Say "Hey there, #{user.first_name}. Do you have a place to stay tonight? Press one for yes or two for no.", :voice => 'alice'
      end
    end

    render_twiml response
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
