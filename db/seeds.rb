# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

def make_user()
	{
		:first_name => Faker::Name.first_name,
		:last_name => Faker::Name.last_name,
		:ssn => Faker::Number.number(9),
		:dob => Faker::Date.backward(90 * 365),
		:created_at => Faker::Date.backward(10 * 365),
		:updated_at => Date.today,
		:phone_number => Faker::PhoneNumber.phone_number,

		:sex => ['Male', 'Female', 'Other', 'Don\'t Know'].sample,
		:vet_status => [0,1].sample,

		# :fleeing => [0, 1].sample,
		# :incarcerated => [0, 1].sample,
		# :welfare => [0, 1].sample,
		# :insufficent_income => [0, 1].sample,
		# :alcohol_or_drug_abuse => [0, 1].sample,
		# :physical_health_issue => [0, 1].sample,
		# :mental_health_issue => [0, 1].sample,
		# :exchange_for_sex => [0, 1].sample,
  }
end

sample_zipcodes = %w[63106 63106 63106 63105 63105 63103 63115 63118 63132 63131 63123 63122 63102 63104 630201 63107 63109 63130 63125 63112 63119]

1000.times do |user_count|
  user = User.create(make_user)
  now = Date.today
  30.times do |i|
    # puts "#{user_count}:#{user.name} - #{i}"
    needs_shelter = Random.rand < 0.25
    date = now - i.days
    History.create(user: user,
                   # simulate phone sign ins from random St Louis locations
                   zipcode: sample_zipcodes.sample,
                   needs_shelter: needs_shelter,
                   fleeing: Random.rand < (needs_shelter ? 0.60 : 0.05),
                   incarcerated: Random.rand < 0.03,
                   welfare: Random.rand < (needs_shelter ? 0.30 : 0.45), # heh, if they can't get welfare, they're more likely to need_shelter
                   insufficent_income: Random.rand < (needs_shelter ? 50 : 25),
                   alcohol_or_drug_abuse: Random.rand < 0.20,
                   physical_health_issue: Random.rand < (needs_shelter ? 50 : 25),
                   mental_health_issue: Random.rand < (needs_shelter ? 50 : 25),
                   exchange_for_sex: Random.rand < 0.18,
                   created_at: date,
                   updated_at: date)
  end
end
