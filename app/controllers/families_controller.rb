class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:new, :create, :index]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/new
  def new
    @family = Family.new event: @event
    @available_participants = @event.participants.without_family
    authorize @family
  end

  # POST /families
  # POST /families.json
  def create
    @family = @event.families.build(family_params.merge(creator: current_user))
    authorize @family

    if @family.save
      redirect_to event_families_path(@event), notice: 'Family was successfully created.'
    else
      render action: 'new'
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    authorize @family
    @family.destroy
    redirect_to event_families_path(@family.event)
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:name, family_members_attributes: %w[id selected])
    end
end
