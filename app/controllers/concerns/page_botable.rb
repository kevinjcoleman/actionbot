module PageBotable
  def find_bot
    @bot = PageBot.find(params[:page_bot_id] || params[:id])
  end
end
