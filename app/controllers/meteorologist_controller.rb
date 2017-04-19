require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    address_with_plus = @street_address.gsub(" ","+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + address_with_plus

    parsed_data1 = JSON.parse(open(url).read)

    latitude = parsed_data1["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data1["results"][0]["geometry"]["location"]["lng"]

    @lat = latitude
    @lng = longitude

    at_long_url_format = @lat + "," + @lng
    url = "https://api.darksky.net/forecast/e52e197a84ae9facc0af0576e2813eab/" + lat_long_url_format

    parsed_data2 = JSON.parse(open(url).read)

    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
