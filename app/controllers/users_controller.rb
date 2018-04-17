class UsersController < ApplicationController

  def index
    @users = User.order("LOWER(display_name) ASC").page(current_page)
  end

  def show
    @user = User.find(params[:id])
  end
end
