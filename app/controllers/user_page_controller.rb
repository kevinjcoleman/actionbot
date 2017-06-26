class UserPageController < ApplicationController
  def create
    page_service = ::PageAdditionService.new(page_params: page_params, user: current_user)
    if page_service.create_and_subscribe!
      redirect_to page_bot_path(page_service.bot)
    else
      flash[:danger] = "Something went wrong."
      redirect_to root_path
    end
  end

  def page_params
    params.require(:page).permit(:page_id, :name, :access_token, :perms)
  end
end
