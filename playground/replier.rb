require 'twilio-ruby'
require 'sinatra'

# fake db idea
user = {id: 1, state: 1}
state = {state: 1, response: 1}

def get_state(user: 1)
	{
		1: {state: 1, response: 1}
	}[user]
end

def initiate_message
	# put your own credentials here
	account_sid = 'AC33bf897e53d130ee970e0682e0d434f6'
	auth_token = 'e18c837ca2681e08b53fc7d928d7affa'

	# set up a client to talk to the Twilio REST API
	@client = Twilio::REST::Client.new account_sid, auth_token

	# alternatively, you can preconfigure the client like so
	Twilio.configure do |config|
	  config.account_sid = account_sid
	  config.auth_token = auth_token
	end

	# and then you can create a new client without parameters
	@client = Twilio::REST::Client.new

	#Send an SMS

	@client.messages.create(
	  from: '+15109013210',
	  # to: '+15105906889',
	  to: '+15732632278',
	  body: 'Do you have shelter tonight? (0 or 1)'
	)
end

def send_message(message)
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message msg
  end
  twiml.text
end

get '/test' do 
	initiate_message()
end

post '/sms' do
  puts "Message: #{params['Body']}!"

  response = params['Body']
  msg = ""
  case get_state()[:state]
  	when 0 
  		#entry state
	when 1
		case response
		when "0"
			msg += "We are glad you are housed."
		when "1"
			msg += "Which zip code are you located at? We can help you find a shelter."
			state[:state] = 2
		end
	when 2
		#look up zip code area
		shelter_list = [{name: "shelter 1"},{name: "shelter 2"}]
		msg += "These are the shelters nearby: \n"

		shelter_list.each_with_index do |shelter, i|
			msg += "#{i}) #{shelter}\n"
		end
		state[:state] = 3
	when 3
		case response
		when "0"
			msg += "You have a bed at: 65491 Blvd.\n"
		when "1"
			msg += "You have a bed at: 12345 Street.\n"
		end
  end

  send_message(msg)
end