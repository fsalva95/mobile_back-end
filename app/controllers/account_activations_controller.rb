class AccountActivationsController < ApplicationController

  skip_before_action :authenticate_request



   def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
   
    else
      #flash[:danger] = "Invalid activation link"
      #redirect_to root_url
    end
  end
end
