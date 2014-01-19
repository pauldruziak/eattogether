class EventsController < ApplicationController
  respond_to :html

  def index
  end

  def new
    @event = Event.new
    @event.participants.build
  end

  def create
    @event = Event.create event_params.merge(creator: current_user)
    respond_with @event
  end

  def show
    @event = Event.find params[:id]
    authorize @event
    respond_with @event
  end

  private

    def event_params
      params.require(:event).permit(:title,
                                    participants_attributes: [:id,
                                                              :default_name,
                                                              :_destroy])
    end
end
