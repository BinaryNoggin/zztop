# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  first_name            :string
#  last_name             :string
#  ssn                   :string
#  dob                   :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  phone_number          :string
#  fleeing               :boolean
#  incarcerated          :boolean
#  welfare               :boolean
#  insufficent_income    :boolean
#  alcohol_or_drug_abuse :boolean
#  physical_health_issue :boolean
#  mental_health_issue   :boolean
#  exchange_for_sex      :boolean
#  sex                   :string
#  vet_status            :boolean
#

class User < ApplicationRecord
end
