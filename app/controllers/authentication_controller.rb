class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request

 def authenticate


   @user=User.find_by(email: params[:email].downcase)

   if @user

       command = AuthenticateUser.call(params[:email], params[:password])

       if command.success?


        if !@user.activated?

            render json: { error: 'not activated' }, status: 401

        else
            render json: { auth_token: command.result }
        end
       else
         render json: { error: command.errors }, status: :unauthorized
       end

   else

    render json: { error: 'not found' }, status: 401

   end

 end
end
