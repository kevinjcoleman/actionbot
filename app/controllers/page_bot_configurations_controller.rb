class PageBotConfigurationsController < ApplicationController
  include PageBotable
  before_action :find_bot

  def show
  end

  def update
    @bot.add_whitelisted_domain(configuration_params[:domain])
    redirect_to page_bot_configuration_path(@bot)
  end

  def destroy
    @bot.remove_whitelisted_domain(configuration_params[:domain])
    redirect_to page_bot_configuration_path(@bot)
  end

  def configuration_params
    params.require(:configuration).permit(:domain)
  end
end
