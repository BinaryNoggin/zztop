# == Schema Information
#
# Table name: histories
#
#  id                    :integer          not null, primary key
#  user_id               :integer
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

  def self.random_question
    %i[fleeing incarcerated welfare insufficent_income alcohol_or_drug_abuse physical_health_issue mental_health_issue exchange_for_sex].sample
  end
end
