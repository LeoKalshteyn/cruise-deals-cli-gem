class CruiseDeals::CLI

  def call
    list_cruises
    menu
    goodbye
  end

  def list_cruises
    puts "Avaliable Cruises:"
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
       if input.to_i > 0
        the_cruise = @cruises[input.to_i-1]
        puts "#{the_cruise.name} - #{the_cruise.price} - #{the_cruise.nights}"
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
