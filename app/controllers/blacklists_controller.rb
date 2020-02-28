class BlacklistsController < ApplicationController
  before_action :set_blacklist, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:check]
  #wrap_parameters :blacklist, include: [:token]

  # GET /blacklists
  def index
    @blacklists = Blacklist.all

    render json: @blacklists
  end

  # GET /blacklists/1
  def show
    render json: @blacklist
  end

  # POST /blacklists
  def create
    @blacklist = Blacklist.new(blacklist_params)

    if @blacklist.save
      render json: @blacklist, status: :created, location: @blacklist
    else
      render json: @blacklist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blacklists/1
  def update
    if @blacklist.update(blacklist_params)
      render json: @blacklist
    else
      render json: @blacklist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blacklists/1
  def destroy
    @blacklist.destroy
  end

  def check
    @token= Blacklist.find_by(token: params[:token])


    render json: @token


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklist
      @blacklist = Blacklist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blacklist_params
      params.require(:blacklist).permit(:token)
    end
end
