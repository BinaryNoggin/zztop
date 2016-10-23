# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  first_name   :string
#  last_name    :string
#  ssn          :string
#  dob          :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  phone_number :string
#  sex          :string
#  vet_status   :boolean
#

class User < ApplicationRecord
  has_many :histories

  def most_recent_history
    histories.order(created_at: :asc).last || histories.build
  end

  def update_question(question, answer)
    new_history = histories.build(most_recent_history.attributes.merge(id: nil))
    new_history.update_attribute(question, answer)
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

  def older_than?(age_in_years)
    dob && dob + age_in_years.years >= Date.today
  end

  def call_number
    "+1#{phone_number}"
  end
end
