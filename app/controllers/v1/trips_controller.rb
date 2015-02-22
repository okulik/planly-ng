module V1
  class TripsController < ApplicationController
    include ActionController::MimeResponds
    include CleanPagination

    before_action :auth
    before_action :set_trip, only: [:show, :update, :destroy]
    before_filter :check_destination, only: :filter

    # GET /trips
    # GET /trips.json
    def index
      where_str = "user_id = :user_id"
      where_hash = { user_id: current_user.id }
      paginate Trip.where(where_str, where_hash).count, 50 do |limit, offset|
        @trips = Trip.where(where_str, where_hash)
          .order(:start_date)
          .limit(limit)
          .offset(offset)
        respond_to do |format|
          format.any(:trips_json, :json) do
            render json: @trips
          end
        end
      end
    end

    # GET /trips/1
    # GET /trips/1.json
    def show
      respond_to do |format|
        format.any(:trips_json, :json) do
          render json: @trip
        end
      end
    end

    # POST /trips
    # POST /trips.json
    def create
      @trip = Trip.new(trip_params.merge(user_id: current_user.id))

      respond_to do |format|
        format.any(:trips_json, :json) do
          if @trip.save
            render json: @trip, status: :created, location: @trip
          else
            render json: @trip.errors, status: :unprocessable_entity
          end
        end
      end
    end

    # PATCH/PUT /trips/1
    # PATCH/PUT /trips/1.json
    def update
      respond_to do |format|
        format.any(:trips_json, :json) do
          if @trip.update(trip_params)
            head :no_content
          else
            render json: @trip.errors, status: :unprocessable_entity
          end
        end
      end
    end

    # DELETE /trips/1
    # DELETE /trips/1.json
    def destroy
      @trip.destroy

      respond_to do |format|
        format.any(:trips_json, :json) do
          head :no_content
        end
      end
    end

    # GET /trips/next_month
    def next_month_trips
      @trips = Trip.
        where('user_id = ? AND start_date >= ? AND start_date < ?',
          current_user.id,
          Date.today.at_beginning_of_month.next_month,
          Date.today.at_beginning_of_month.next_month + 1.month).
        order(:start_date)
      respond_to do |format|
        format.any(:trips_json, :json) do
          render json: @trips
        end
      end
    end

    # GET /trips/filter
    def filter
      @trips = Trip.where('destination ILIKE :dest AND user_id = :user_id',
        dest: "%#{params[:destination]}%", user_id: current_user.id)
        .order(:start_date)

      respond_to do |format|
        format.any(:trips_json, :json) do
          render json: @trips
        end
      end
    end

    private
    def set_trip
      @trip = Trip.where(tid: params[:tid], user_id: current_user.id).take
      
      unless @trip
        respond_to do |format|
          format.any(:trips_json, :json) do
            render nothing: true, status: :not_found 
          end
        end
      end
    end

    def trip_params
      params.require(:trip).permit(:destination, :start_date, :end_date, :comment, :user_id)
    end

    def auth
      # logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
      # self.request.env.each do |header|
      #   logger.warn "HEADER KEY: #{header[0]}"
      #   logger.warn "HEADER VAL: #{header[1]}"
      # end
      # logger.warn "*** END RAW REQUEST HEADERS ***"
      authenticate_user!
    end

    def check_destination
      render nothing: true, status: :bad_request unless params[:destination]
    end
  end
end
