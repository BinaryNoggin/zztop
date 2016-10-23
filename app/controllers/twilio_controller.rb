class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def respond_to_homeless_voice
    answer = params[:Digits].to_i
    response = Twilio::TwiML::Response.new do |r|
      case answer
      when 1
        ask_survey_question(r)
        user.update_question(:needs_shelter, true)
      when 2
        respond_with_shelters(r, user)
        user.update_question(:needs_shelter, false)
      else
        ask_for_shelter_again(r)
      end
    end

    render_twiml response
  end

  def respond_to_question_voice
    answer = params[:Digits]
    user.update_question(params[:question], answer == "1")
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Thanks for helping us keep our records up to date.", voice: "alice"
    end

    render_twiml response
  end

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: 1, action: user_twilio_respond_to_homeless_voice_url(user) do |g|
        g.Say "Hey there, #{user.first_name}. Do you have a place to stay tonight? Press one for yes or two for no.", voice: "alice"
      end
    end

    render_twiml response
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def ask_survey_question(r)
    question = History.random_question
    r.Gather numDigits: 1, action: user_twilio_respond_to_question_voice_url(user, question) do |g|
      g.Say I18n.translate("simple_form.labels.defaults.#{question}") + "Press one for yes or two for no.", voice: "alice"
    end
  end

  def ask_for_shelter_again(r)
    r.Gather numDigits: 1, action: user_twilio_respond_to_homeless_voice_url(user) do |g|
      g.Say "Sorry, #{user.first_name}. I don't understand your response. Do you have a place to stay tonight? Press one for yes or two for no.", voice: "alice"
    end
  end

  def respond_with_shelters(r, user)
    shelters = Coc.find_for_user(User.second).select {|h| h[:services].include?(:housing)}.map {|h| h[:name]}.join(', ')
    if shelters
      r.Say "You may be able to stay at #{shelters}", voice: "alice"
    else
      r.Say "We don't know of any shelters that will take you. We're very sorry, #{user.first_name}.", voice: "alice"
    end
  end

  # untested
  def send_shelter_text(shelters, user, text)
    Twilio::REST::Client.new.messages.create(
      from: PHONE_NUMBER,
      to: user.call_number,
      body: "Blah blah blah shelters")
  end
end
