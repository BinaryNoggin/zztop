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
#  grade        :decimal(8, 5)
#

class User < ApplicationRecord
  has_many :histories

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
      localize @user.dob, format: :long
    end
  end
end
