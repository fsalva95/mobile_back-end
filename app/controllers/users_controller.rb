class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request
  wrap_parameters :user, include: [:name,:email,:address,:mobile, :password, :password_confirmation] #importante


  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      #flash[:info] = "Please check your email to activate your account."
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @user.destroy
  end

    def googlelog

        @user=User.find_by(email: params[:email].downcase)
        if @user
            command=JsonWebToken.encode(user_id: @user.id)
            render json: { auth_token: command }

        else
            @user= User.create_from_auth(params[:email].downcase,params[:name])
            command=JsonWebToken.encode(user_id: @user.id)
            render json: { auth_token: command }
        end


    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email,:address,:mobile,:password, :password_confirmation)
    end
end
