class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :pincode]
  before_action :set_event, except: [:index, :new, :create]

  after_action :verify_authorized, except: [:index, :pincode]
  after_action :verify_policy_scoped, only: [:index]

  def index
    @events = policy_scope(Event)
  end

  def show
    authorize @event
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def user_not_authorized
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
      redirect_to @event
    else
      flash.now[:alert] = I18n.t('controllers.events.only_pincode.') if params[:pincode].blank?
      flash.now[:alert] ||= I18n.t('controllers.events.wrong_pincode')
      render 'password_form', status: :service_unavailable
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end
end
