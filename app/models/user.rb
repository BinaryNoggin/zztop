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
#  grade                 :decimal(8, 5)
#

class User < ApplicationRecord

  def letter_grade
    case grade
    when 80..100
      'F'
    when 65...80
      'D'
    when 50...65
      'C'
    when 30...50
      'B'
    when 0...30
      'A'
    else
      ''
    end
  end

end
