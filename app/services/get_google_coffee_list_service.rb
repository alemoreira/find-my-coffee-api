require 'rest-client'
require 'json'

class GetGoogleCoffeeListService
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
  
  def call
    begin
      query = "query=coffee+shops"
      location = "location=#{@latitude},#{@longitude}"
      radius = "radius=500"
      key = "key=#{Rails.application.credentials.google_secret_key}"
      base_url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
      url = "#{base_url}?#{query}&#{location}&#{radius}&#{key}"

      response = RestClient.get(url)
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end