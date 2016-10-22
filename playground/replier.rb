require 'twilio-ruby'
require 'sinatra'

# fake db idea
$valid_states = [:ask_housing, :ask_location]

$users = {
    1 => {name: "bob"},
    2 => {name: "sam"}
}

$states = {
    1 => {state: :welcome, last_response: 1},
    2 => {state: :ask_location, last_response: 2}
}

# The key of the hash is the current state the user is in. 
# The proc it points to has 2 responsibilities, 1) set the next state 
# and 2) return a string to be sent back via text
$transitions = {
    :welcome => ->(user, input) {
        set_state(user, :ask_housing, input)
        return "Are you currently housed? (y or n)"
    },
    :ask_housing => ->(user, input) { 
        case input
        when "y", "Y", 1
            set_state(user, :fin, input)
            return "We are happy that you are currently housed."
        when "n", "N", 0
            set_state(user, :ask_location, input)
            return "Provide us with a zip code if you want help. Reply with 'end' otherwise."
        end
    },
    :ask_location => ->(user, input) {
        case input
        when "end"
            set_state(user, :fin, input)
            return "We are happy that you are currently housed."
        when /([0-9]{5})/
            set_state(user, :ask_shelter_perference, input)
            #TODO: lookup shelters nearby
            possible_shelters = find_shelters_for(user)

            return "These are the options: " + possible_shelters.to_s
        else
            set_state(user, :ask_location, input)
            return "Provide us with a zip code if you want help. Reply with 'end' otherwise."
        end
    },
    :ask_shelter_perference => -> (user, input) {
        valid_shelters = find_shelters_for(user).keys

        if valid_shelters.contains?(input)
            set_state(user, :fin, input)
            return "You have a room booked at: " + find_shelters_for(user)[input]
        else
            return "These are the options: " + possible_shelters.to_s
        end 
    },
    :thank_you => ->(user, input) {
        return "Thank you for responding."
    },
    :emergency => ->(user, input) {

    },
    :fin => ->(user, input) {
        return "Thank you for using our service."
    }
}

### Shelter Lookup
def find_shelters_for(user)
    {
        1 => {101 => {name: "Bob's Crab Shack", open_beds: 1}, 
        102 => {name: "Sam's Club", open_beds: 5}}
    }[user]
end

### State Functions
def get_state(user)
    $states[user]
end

def clear_state(user)
    $states[user] = {state: :welcome, response: 0}
end

def set_state(user, state, input)
    $states[user] = {state: state, last_response: input}
end

def transition_state(user, from, input)
    state = get_state(user)
    puts "DEBUG: Transition on user: #{user}, with state #{state}"

    transition = $transitions[from]
    msg = transition.call(user, input)

    state = get_state(user)
    puts "DEBUG: Resulting user: #{user}, with state #{state}"
    puts "DEBUG: Response: #{msg}"

    return msg
end

### User Functions
def get_user_id()
    1
end

### Twilio Stuff
def initiate_message(user_id)
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

    #reset and get first state, EDIT: acting weird because I am usinga global var
    # clear_state(user_id);
    # msg = transition_state(user_id, :welcome, 1)

    #Send an SMS
    @client.messages.create(
      from: '+15109013210',
      # to: '+15105906889',
      to: '+15105906889',
      body: "Welcome to the zztop less homeless system. Reply if you wish to continue."
    )
end

def send_response(msg)
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message msg
  end
  twiml.text
end

### Rest API 
# This step should be done with the user registration. 
# And on a timer/tied to the button on the user management page. 
get '/initiate/:user_id' do 
    initiate_message(params['user_id'])
end

# This is basically the interface into the state machine.
# This endpoint can essentially only reply. 
post '/sms' do
  puts "DEBUG: Input #{params['Body']}!"

  input = params['Body']
  user = get_user_id()
  state = get_state(user)

  msg = transition_state(user, state[:state], input)

  send_response(msg)
end