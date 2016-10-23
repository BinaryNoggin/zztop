class HistoryController < ApplicationController
  def index
    @histories = History.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @histories }
    end
  end

  def update
    if params[:id].to_i == 0
      @history = History.where(:rating => nil)

      @history.each do |entry|
        entry[:rating] = _grade_history(entry)[0] * 100
        entry.save
      end
    else
      @history = History.where(user_id: params[:id]).order(:updated_at).first

      @history[:rating] = _grade_history(@history)[0] * 100

      if @history.save
        redirect_to action: 'index', notice: 'History successfully created.'
      else
        render action: 'new'
      end
    end
  end

  def _extract_fields(history)
    input = []
    ['fleeing', 'incarcerated', 'welfare', 'insufficent_income', 
      'alcohol_or_drug_abuse', 'physical_health_issue', 
      'mental_health_issue', 'exchange_for_sex'
    ].each do |field|
      input << (history[field] == true ? 1 : 0)
    end

    desired_output = history['needs_shelter'] == true ? [1] : [0]

    {input: input, desired_output: desired_output}
  end

  def _grade_history(history)
    fann = RubyFann::Standard.new(:filename=>"foo.net")  
    fann.run(_extract_fields(history)[:input])
  end
end
