class BotEventsController < ApplicationController
  include PageBotable
  before_action :find_bot
  before_action :find_event, except: [:index, :create, :new]

  def show

  end

  def index
    @events = @bot.bot_events
  end

  def new
    @event = @bot.bot_events.new
  end

  def create
    service = BotEventCreationService.new(@bot, bot_event_params)
    begin
      service.create_event
      redirect_to page_bot_bot_event_path(@bot, service.event)
    rescue => e
      flash[:danger] = "#{e.message}"
      render :new
    end
  end

  def edit
  end

  def update
    service = BotEventUpdaterService.new(@bot, @event, bot_event_params)
    begin
      service.update_event
      redirect_to page_bot_bot_event_path(@bot, @event)
    rescue => e
      flash[:error] = "#{e.message}"
      render :edit
    end
  end

  def destroy
  end

  def bot_event_params
    params.require(:bot_event).permit(:name, :start_at, :end_at, :address_line, :picture_url, :description)
  end

  def find_event
    @event = BotEvent.find(params[:id])
  end
end
