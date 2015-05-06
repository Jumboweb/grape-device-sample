module GrapeDeviceSample
  module V1
    class Users < Grape::API
      include GrapeDeviceSample::V1::Defaults


      resource :users do

        desc "Return list of users"
        get do
          authenticate!
          User.all
        end

        desc "Return a user"
        params do
          requires :id, type: Integer, desc: "User id"
        end
        route_param :id do
          get do
            User.find(params[:id])
          end
        end

        desc "Create a user"
        params do
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
        end
        post do
          user = User.create({
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation]
          })
          error!("hey", 400) unless user.valid?
        end

        desc "Update a user"
        params do
          optional :email, type: String
        end
        put ':id' do
          User.find(params[:id]).update({
            email: params[:email]
          })
        end

        desc "Sign In"
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post 'signin' do
          user = User.find_by_email(params[:email])
          if user && user.valid_password?(params[:password])
            user
          else
            error!('403 forbidden', 403)
          end
        end
      end
    end
  end
end
