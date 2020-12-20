class AirplanesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
  end

  def seats
    return if params['seats'].blank?
    seats = JSON.parse(params['seats'])
    passengers = params['passenger'].to_i
    no_of_columns = seats.length
    max_no_of_passengers = seats.inject(0) {|sum, column| sum += column[0] * column[1]}
    first = window_seat_generator(seat.first)
    last = window_seat_generator(seat.last) if no_of_columns > 1
    other_seat_generator(seat[1..(no_of_columns-2)]) if no_of_columns > 2
  end

  def window_seat_generator(seat)

  end
end
