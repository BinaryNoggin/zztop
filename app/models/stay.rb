# == Schema Information
#
# Table name: stays
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  shelter_id     :integer
#  check_in_date  :date
#  check_out_date :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_stays_on_shelter_id  (shelter_id)
#  index_stays_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_57a645631d  (user_id => users.id)
#  fk_rails_9855e27a5b  (shelter_id => shelters.id)
#

class Stay < ApplicationRecord
  belongs_to :user
  belongs_to :shelter
end
