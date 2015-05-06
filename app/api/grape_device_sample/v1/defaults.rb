module GrapeDeviceSample
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :path
        format :json
        prefix :api

        # global exception handler, used for error notifications
        rescue_from :all do |e|
          if Rails.env.development?
            error_response(message: e.message, status: 500)
          else
            error_response(message: "Internal server error", status: 500)
          end
        end


        helpers do
          def current_user
            @current_user ||= User.find_by_authentication_token(headers['Authorization'])
          end

          def authenticate!
            error!('401 Unauthorized', 401) unless current_user
          end
        end

      end
    end
  end
end
