class Users::CallsController < ApplicationController
  include Webhookable

  def new
    user = User.find(params[:user_id])
    client.calls.create(
      from: "+15736774332",
      to: user.call_number,
      url: user_twilio_url(user)
    )
  end

  private def client
    @client ||= Twilio::REST::Client.new
  end
end
