class ProfileController < ApplicationController

    def info

        @user= User.find_by(email: params[:email].downcase)
        render json: @user

    end

end
