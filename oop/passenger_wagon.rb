class PassengerWagon < Wagon
  attr_reader :occupied_places, :seats_count

  def initialize(seats_count)
    @seats_count = seats_count
    @occupied_places = 0
  end

  def check_in
    if seats_count > occupied_places
      self.occupied_places += 1
      puts "Теперь в вагоне занято #{occupied_places} мест"
    else
      puts 'В вагоне не осталось свободных мест'
    end
  end

  def check_out
    if occupied_places > 0
      self.occupied_places -= 1
      puts 'Пассажир покинул вагон'
    else 
      puts "В вагоне не осталось пассажиров"
    end
  end

  def free_places
    seats_count - occupied_places
  end

  def type
    :passenger
  end
  private
  attr_writer :occupied_places
end
