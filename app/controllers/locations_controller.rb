require 'rubygems'
require 'open-weather-api'
require 'json'
class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  @@open_weather_api = OpenWeatherAPI::API.new api_key: "f47eb12edb20f01ceb91fcb8d27a3473", default_language: 'es', default_units: 'metric', default_country_code: 'es'
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @zip = @location.zipcode
    @current= JSON.parse((@@open_weather_api.current zipcode: @zip,   country_code: 'us').to_json)
    @daily= JSON.parse((@@open_weather_api.forecast :daily, city: @current['name'],   country_code: 'us', days: 2).to_json)
    @liveTemp=(((@current['main']["temp"])-273) *9.0/5.0+32).round(2)

  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:zipcode)
    end
end
