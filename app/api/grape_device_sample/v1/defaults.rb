module GrapeDeviceSample
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :path
        format :json
        prefix :api

        # global handler for simple not found case
        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        # global handler for simple not found case
        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 500)
        end

        # global exception handler, used for error notifications
        rescue_from :all do |e|
          error_response(message: e.message, status: 500)
          if Rails.env.development?
            raise e
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
