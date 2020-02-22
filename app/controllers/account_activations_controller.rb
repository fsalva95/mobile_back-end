class AccountActivationsController < ApplicationController

  skip_before_action :authenticate_request



   def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      #log_in gamer
      #flash[:success] = "Account activated!"
      #redirect_to new_account_attribute_url(email: gamer.email)     #memorizzo i dati aggiuntivi richiesti per il gamer
    else
      #flash[:danger] = "Invalid activation link"
      #redirect_to root_url
    end
  end
end
