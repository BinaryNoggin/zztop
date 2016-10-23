class AddingRating < ActiveRecord::Migration[5.0]
  def up
      History.where(:rating => nil).each do |history|
        result = HistoryController.new.send(:_grade_history, history)[0]
        result *= 100
        history[:rating] = result
        p history
        history.save
      end
  end
end
