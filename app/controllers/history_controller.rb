class HistoryController < ApplicationController
  def index
    @histories = History.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @histories }
    end
  end
end
