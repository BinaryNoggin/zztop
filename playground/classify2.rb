require 'ruby-fann'
require 'json'

def extract_fields(entry)
	input = []
	['fleeing', 'incarcerated', 'welfare', 'insufficent_income', 
		'alcohol_or_drug_abuse', 'physical_health_issue', 
		'mental_health_issue', 'exchange_for_sex'
	].each do |field|
		input << (entry[field] == true ? 1 : 0)
	end

	desired_output = entry['needs_shelter'] == true ? [1] : [0]

	{input: input, desired_output: desired_output}
end

def train
	file = File.read('dump.json')
	data_hash = JSON.parse(file)

	# classifier = ClassifierReborn::Bayes.new "Homeful", "Homeless"

	# count_homeless = 0
	inputs = []
	desired_outputs = []

	data_hash.each do |entry|
		extracted = extract_fields(entry)

		inputs << extracted[:input]
		desired_outputs << extracted[:desired_output]
	end

	train = RubyFann::TrainData.new(:inputs => inputs, :desired_outputs => desired_outputs)
	fann = RubyFann::Standard.new(:num_inputs=>8, :hidden_neurons=>[16, 16], :num_outputs=>1)
	fann.train_on_data(train, 50, 10, 0.1)

	return fann
end

def write_model(fann)
  fann.save('foo.net')
end

def read_model
	RubyFann::Standard.new(:filename=>"foo.net")
end    

def test_user(fann, user)
	fann.run(extract_fields(user)[:input])
end

# # Create Model
fann = train()
write_model(fann)

## Load Model
# fann = read_model
puts test_user(
	fann,
	JSON.parse('{
    "fleeing": false,
    "incarcerated": false,
    "welfare": false,
    "insufficent_income": false,
    "alcohol_or_drug_abuse": false,
    "physical_health_issue": false,
    "mental_health_issue": false,
    "exchange_for_sex": false
  }'),
)

puts test_user(
	fann,
	JSON.parse('{
    "fleeing": false,
    "incarcerated": true,
    "welfare": false,
    "insufficent_income": true,
    "alcohol_or_drug_abuse": false,
    "physical_health_issue": true,
    "mental_health_issue": false,
    "exchange_for_sex": true
  }'),
)

puts test_user(
	fann,
	JSON.parse('{
    "fleeing": true,
    "incarcerated": false,
    "welfare": false,
    "insufficent_income": false,
    "alcohol_or_drug_abuse": false,
    "physical_health_issue": false,
    "mental_health_issue": false,
    "exchange_for_sex": false
  }'),
)

puts test_user(
	fann,
	JSON.parse('{
    "fleeing": true,
    "incarcerated": true,
    "welfare": true,
    "insufficent_income": true,
    "alcohol_or_drug_abuse": true,
    "physical_health_issue": true,
    "mental_health_issue": true,
    "exchange_for_sex": true
  }'),
)