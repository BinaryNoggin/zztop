class Users::CallsController < ApplicationController
  include Webhookable

  def new
    user = User.find(params[:user_id])
    client.calls.create(
      from: PHONE_NUMBER,
      to: user.call_number,
      url: user_twilio_voice_url(user)
    )
    redirect_to user
  end

  private def client
    @client ||= Twilio::REST::Client.new
  end
end
