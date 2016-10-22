require 'sinatra'
require 'faker'
require 'json'

set :port, 9494

def make_user()
	{
		"UUID" => Faker::Number.number(10),
		"First_Name" => Faker::Name.first_name,
		"Middle_Name" => Faker::Name.first_name,
		"Last_Name" => Faker::Name.last_name,
		"Name_Data_Quality" => 1,
		"SSN" => Faker::Number.number(9),
		"SSNDataQuality" => 1,
		"DOB" => Faker::Date.backward(90 * 365),
		"DOBDataQuality" => 1,
		# "AmIndAKNative" => Faker::Lorem.word,
		# "Asian" => Faker::Lorem.word,
		# "Black" => Faker::Lorem.word,
		# "NativeHIOtherPacific" => Faker::Lorem.word,
		# "White" => Faker::Lorem.word,
		# "RaceNone" => Faker::Lorem.word,
		# "Gender" => Faker::Lorem.word,
		# "OtherGender" => Faker::Lorem.word,
		# "VeteranStatus" => Faker::Lorem.word,
		# "YearEnteredService" => Faker::Lorem.word,
		# "YearSeparated" => Faker::Lorem.word,
		# "WorldWarII" => Faker::Lorem.word,
		# "KoreanWar" => Faker::Lorem.word,
		# "VietnamWar" => Faker::Lorem.word,
		# "DesertStorm" => Faker::Lorem.word,
		# "AfghanistanOEF" => Faker::Lorem.word,
		# "IraqOIF" => Faker::Lorem.word,
		# "IraqOND" => Faker::Lorem.word,
		# "OtherTheater" => Faker::Lorem.word,
		# "MilitaryBranch" => Faker::Lorem.word,
		# "Discharge_Status" => Faker::Lorem.word,
		"Date_Created" => Faker::Date.backward(1000),
		"DateUpdated" => Date.today,
		"UserID" => Faker::Number.number(10),
		"PhoneNumber" => Fake.PhoneNumber.phone_number,
	}
end

def make_disability(user_id)
	{
		"DisabilitiesID" => Faker::Number.number(10),
		"ProjectEntryID" => Faker::Number.number(10),
		"PersonalID" => Faker::Number.number(10),
		"InformationDate" => Faker::Date.backward(1000),
		"DisabilityType" => Faker::Number.number(1),
		# "DisabilityResponse" => 1,
		# "IndefiniteAndImpairs" => 1,
		# "DocumentationOnFile" => 1,
		# "ReceivingServices" => 1,
		# "PATHHowConfirmed" => 1,
		# "PATHSMIInformation" => 1,
		# "TCellCountAvailable" => 1,
		# "TCellCount" => 1,
		# "TCellSource" => 1,
		# "ViralLoadAvailable" => 1,
		# "ViralLoad" => 1,
		# "ViralLoadSource" => 1,
		# "DataCollectionStage" => 1,
		# "DateCreated" => 1,
		# "DateUpdated" => 1,
		"UserID" => user_id,
		# "DateDeleted" => 1,
		# "ExportID" => 1,
	}
end

get '/user' do 
	return make_user.to_json
end

get '/disability/:user_id' do 
	return make_disability(params['user_id']).to_json
end