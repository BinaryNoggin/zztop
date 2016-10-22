# == Schema Information
#
# Table name: shelters
#
#  id          :integer          not null, primary key
#  name        :string
#  address     :string
#  description :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# A shelter (technically a CoC/HMIS Project) is a unit of an organization,
# that provides services and/or lodging to the homeless.
class Shelter < ApplicationRecord
end
