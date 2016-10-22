# == Schema Information
#
# Table name: histories
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  zipcode               :string
#  needs_shelter         :boolean
#  rating                :integer
#  fleeing               :boolean
#  incarcerated          :boolean
#  welfare               :boolean
#  insufficent_income    :boolean
#  alcohol_or_drug_abuse :boolean
#  physical_health_issue :boolean
#  mental_health_issue   :boolean
#  exchange_for_sex      :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_histories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_ddbf5f9cca  (user_id => users.id)
#

class History < ApplicationRecord
  belongs_to :user
end
