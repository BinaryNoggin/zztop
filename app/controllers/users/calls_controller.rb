class Users::CallsController < ApplicationController
  include Webhookable

  def new
    user = User.find(params[:user_id])
    client.calls.create(
      from: "+13143100233",
      to: user.call_number,
      url: user_twilio_voice_url(user)
    )
  end

  private def client
    @client ||= Twilio::REST::Client.new
  end
end
