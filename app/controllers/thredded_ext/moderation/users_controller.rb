# frozen_string_literal: true

module ThreddedExt
  module Moderation
    class UsersController < ApplicationController
      def update
        return head(:unauthorized) unless current_user.admin?
        user = Thredded.user_class.find(params[:id])
        user.update(params.require(:user).permit(:moderator))
        redirect_back fallback_location: thredded.user_moderation_path(user.id)
      end
    end
  end
end
