class EventsController < ApplicationController
  respond_to :html

  def index
    if current_user.events.empty?
      redirect_to new_event_path
    else
      redirect_to event_path(current_user.events.last)
    end
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
