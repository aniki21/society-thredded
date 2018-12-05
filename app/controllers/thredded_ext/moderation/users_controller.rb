# frozen_string_literal: true

module ThreddedExt
  module Moderation
    class UsersController < ApplicationController
      def update
        return head(:unauthorized) unless current_user.admin?
        user = Thredded.user_class.find(params[:id])
        user[Thredded.moderator_column] = params.require(:user).permit(:moderator)
        user.save
        redirect_back fallback_location: thredded.user_moderation_path(user.id)
      end
    end
  end
end
