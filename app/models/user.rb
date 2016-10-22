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
#

class User < ApplicationRecord
end
