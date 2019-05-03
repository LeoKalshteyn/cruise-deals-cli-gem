class CruiseDeals::CLI
  include CommandLineReporter

  def call
    list_cruises
    menu
    goodbye
  end

  def list_cruises
    # Calls the scrape method and iterates through the cruise array, displaying all the name
    puts "Avaliable Cruises:"
    CruiseDeals::Cruise.scrape_cruisecritic
    @cruises = CruiseDeals::Cruise.avaliable
    @cruises.each.with_index(1) do |cruise, i|
      puts "#{i}. #{cruise.name}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the cruise you'd like more info on or type list to see the deals again or type exit:"
      input = gets.strip.downcase

       #if input.to_i && input.to_i < @cruises.length
       if input.to_i > 0 && input.to_i <= 20
        the_cruise = @cruises[input.to_i-1]
          puts ""
          #sprintf("%10d", "#{the_cruise.name}")
          puts "#{the_cruise.name}"
          puts ""
          puts "Price:           #{the_cruise.price}"
          puts "Nights:          #{the_cruise.nights}"
          puts "Date:            #{the_cruise.date}"
          puts "From:            #{the_cruise.from}"
          puts "Ship Name:       #{the_cruise.ship_name}"
          puts "Room Category:   #{the_cruise.room_category}"
          puts ""
      elsif input == "list"
        list_cruises
      else
        puts "Not sure what you want, type list or exit."
      end
    end
  end

  def goodbye
    puts "See you tomorrow for more deals!!!"
  end
end
