class PageBotsController < ApplicationController
  def show
    @bot = PageBot.find(params[:id])
  end
end
