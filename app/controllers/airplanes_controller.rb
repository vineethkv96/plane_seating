require 'airplane_seating'

class AirplanesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    return if params['seats'].blank? || params['passenger'].blank?
    begin
      seats = JSON.parse(params['seats'])
    rescue
      render 'airplanes/output_template', layout: false, locals: {seats: "seat order should be 2D array, example [[3,4], [4,5], [2,3], [3,4]]"} 
      return
    end
    passengers = params['passenger'].to_i
    airplane = AirplaneSeating.new(seats, passengers)
    render 'airplanes/output_template', layout: false, locals: {seats: airplane.fill_seats}
  end
end
