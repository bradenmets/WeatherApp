require 'rubygems'
require 'open-weather-api'
require 'json'
class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  @@open_weather_api = OpenWeatherAPI::API.new api_key: "f47eb12edb20f01ceb91fcb8d27a3473", default_language: 'es', default_units: 'imperial', default_country_code: 'us'
  
  # GET /locations
  # GET /locations.json
  def index
    @zipcode= zip_params
    if(@zipcode!=false)
      render :show
    else
      flash[:notice]="Please enter a valid zipcode"
      render :index
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show 

    @rightNow =Time.new
    @zipcode=zip_params
    if(@zipcode==false)
      flash[:notice]="Please enter a valid zipcode"
      render :index
    end
    @current= JSON.parse((@@open_weather_api.current zipcode: 95821).to_json)
    @daily= JSON.parse((@@open_weather_api.forecast :daily, city: @current['name'], days: 2).to_json)    
    @liveTemp=toFahr(@current['main']['temp'])
    @forecastTemps=[]
    @maxTemp = -500
    @minTemp = 500
    @daily['list'].each do |child| 
      @forecastTemps << [child['dt_txt'],toFahr(child['main']['temp'])]
      @maxTemp = toFahr(child['main']['temp'])>@maxTemp? toFahr(child['main']['temp']) : @maxTemp
      @minTemp =   [toFahr(child['main']['temp']),@minTemp].min       
    end
  end

  # GET /locations/new
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location

    end
    def toFahr kelv 
      ((kelv-273)*9/5.0+32).round(2)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:zipcode)
    end
    def zip_params
        if(params.has_key?(:zipcode)&&/\d{5}/.match(params[:zipcode]))
          return params[:zipcode]
        else
          return false
        end

    end
end
