class AirplaneSeating
  def initialize(input_array, passenger_count)
    @input_array = input_array
    @max_no_of_passengers = input_array.inject(0) {|sum, column| sum += column[0] * column[1]}
    @passenger_count = passenger_count
    @available_count = passenger_count
    @current_passenger = 0
    @no_of_rows = @input_array.map { |mxn| mxn[1] }.sort.last
    @no_of_columns = input_array.length
  end

  def fill_seats
    return "seat order should be 2D array, example [[3,4], [4,5], [2,3], [3,4]]" unless input_array_validate?
    return "Passenger count greater than seating capacity!" unless validate?
    structure = seating_structure
    seats_front_to_back(structure)
    fill_aisle_seats
    fill_window_seats
    fill_center_seats
    return @front_to_back_seats
  end

  private

  def seating_structure
    @input_array.inject([]) { |structure_array, seats| structure_array << (1..seats[1]).inject([]) { |array| array << (1..seats[0]).inject([]) { |sub_array| sub_array.append("X") } } }
  end

  def seats_front_to_back(structure)
     @front_to_back_seats = (0..@no_of_rows-1).inject([]) { |array, index| array << structure.map { |seat| seat[index] } }
  end

  def increment_passenger_count
    if @available_count > 0
      @current_passenger+=1
      @available_count-=1
      return true
    else
      return false
    end
  end

  def fill_aisle_seats
    first = 0
    last = @no_of_columns-1
    @front_to_back_seats.each_with_index do |row, index_row|
      row.each_with_index do |columns, index_column|
        next if columns.nil?
        if index_column == first
          @front_to_back_seats[index_row][index_column].last.gsub!('X', @current_passenger.to_s) if increment_passenger_count
        elsif index_column == last
          @front_to_back_seats[index_row][index_column].first.gsub!('X', @current_passenger.to_s) if increment_passenger_count
        else
          if columns.count >= 2
            @front_to_back_seats[index_row][index_column].first.gsub!('X', @current_passenger.to_s) if increment_passenger_count
            @front_to_back_seats[index_row][index_column].last.gsub!('X', @current_passenger.to_s) if increment_passenger_count
          else
            @front_to_back_seats[index_row][index_column].first.gsub!('X', @current_passenger.to_s) if increment_passenger_count
          end
        end
      end
    end
  end

  def fill_window_seats
    first = 0
    last = @no_of_columns-1
    @front_to_back_seats.each_with_index do |row, index_row|
      row.each_with_index do |columns, index_column|
        next if columns.nil?
        if index_column == first
          @front_to_back_seats[index_row][index_column].first.gsub!('X', @current_passenger.to_s) if increment_passenger_count
        elsif index_column == last
          @front_to_back_seats[index_row][index_column].last.gsub!('X', @current_passenger.to_s) if increment_passenger_count
        end
      end
    end
  end

  def fill_center_seats
    @front_to_back_seats.each_with_index do |row, index_row|
      row.each_with_index do |columns, index_column|
        next if columns.nil?
        columns.each_with_index do |seat, index_seat|
          if @front_to_back_seats[index_row][index_column][index_seat] == "X"
            @front_to_back_seats[index_row][index_column][index_seat].gsub!('X', @current_passenger.to_s) if increment_passenger_count
          end
        end
      end
    end
  end

  def validate?
    @max_no_of_passengers >= @passenger_count
  end

  def input_array_validate?
    @input_array.all? { |e| e.class==Array } && @input_array.map(&:size).uniq.size == 1 && @input_array.first.class == Array
  end

end