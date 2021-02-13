require 'rest-client'
require 'json'

class GetGoogleCoffeeDetailsService
  def initialize(google_place_id)
    @google_place_id = google_place_id
  end

  def call
    begin
      key = "key=#{Rails.application.credentials.google_secret_key}"
      place_id = "place_id=#{@google_place_id}"
      base_url = "https://maps.googleapis.com/maps/api/place/details/json"
      url = "#{base_url}?#{place_id}&#{key}"

      response = RestClient.get(url)
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end