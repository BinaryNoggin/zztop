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
  has_many :histories

  def most_recent_histroy
    hsitories.last || histories.new
  end

  def update_question(question, answer)
    current_history = history || build_history
    current_history.update_attribute(question, answer)
  end

  def male?
    !! (sex =~ /\Amale\z/i)
  end

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
      'unknown'
    end
  end

  def grade
    most_recent_history.rating
  end

  def name
    "#{first_name} #{last_name}"
  end

  def entered_on
    created_at.to_date
  end

  def date_of_birth
    if dob.nil?
      ""
    else
      I18n.localize dob, format: :long
    end
  end

  def call_number
    "+1#{phone_number}"
  end
end
