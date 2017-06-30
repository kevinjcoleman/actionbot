class PageBotsController < ApplicationController
  include PageBotable
  before_action :find_bot, only: [:show]
  def show
  end

  def index
  end
end
