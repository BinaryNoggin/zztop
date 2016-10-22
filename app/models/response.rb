# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  answer      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_responses_on_question_id  (question_id)
#  index_responses_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_2bd9a0753e  (user_id => users.id)
#  fk_rails_325af149a3  (question_id => questions.id)
#

class Response < ApplicationRecord
  belongs_to :user
  belongs_to :question
end
