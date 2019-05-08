require 'colorize'

class CruiseDeals::CLI

  def call
    menu
  end

  def list_cruises(url)
    # Calls the scrape method and iterates through the cruise array, displaying all the cruise deals
    puts "Avaliable Cruises:"
    CruiseDeals::Cruise.scrape_cruisecritic(url)
    @cruises = CruiseDeals::Cruise.avaliable
    @cruises.each.with_index(1) do |cruise, i|
      puts "#{i}. #{cruise.name}"
    end
  end

  def menu
    #Method that displays the site's details and prompts the user depending on the input.
    input = nil
    puts "Which type of deal would you like more info on?"
    puts "Type in the number of the deal type, (1) All Cruises, (2) Cheapest Cruises, or (3) Last Minute Deals. To exit enter (exit)"
    input = gets.strip
    if input == "1"
      url = "https://www.cruisecritic.com/bargains/"
      list_cruises(url)
      choose_cruise
    elsif input == "2"
      url = "https://www.cruisecritic.com/bargains/cheap-cruises/"
      list_cruises(url)
      choose_cruise
    elsif input == "3"
      url = "https://www.cruisecritic.com/bargains/lastminute.cfm"
      list_cruises(url)
      choose_cruise
    elsif input == "exit"
      goodbye
    else
      puts "Please enter 1-3 for your selection: (1) All Cruises, (2) Cheapest Cruises, or (3) Last Minute Deals"
      menu
    end

  end

  def choose_cruise
    input = nil
    puts "Enter the number of the cruise you'd like more info on or enter list to choose a new deal type."
    input = gets.strip.downcase
    #Less/equal to 20 because there are only 20 cruises displayed at one time.
     if input.to_i > 0 && input.to_i <= 20
      the_cruise = @cruises[input.to_i-1]
        puts "\n#{the_cruise.name}".colorize(:yellow)
        puts "Price:           #{the_cruise.price}"
        puts "Nights:          #{the_cruise.nights}\n\n"
        puts "Date:            #{the_cruise.date}"
        puts "From:            #{the_cruise.from}"
        puts "Ship Name:       #{the_cruise.ship_name}"
        puts "Room Category:   #{the_cruise.room_category}"
        puts "Company Name:    #{the_cruise.company_name}"
        puts "Itinerary:\n    #{the_cruise.itinerary}"
        menu
    elsif input == "list"
      menu
    elsif input != "exit"
      puts "Not sure what you want, type list or exit."
      choose_cruise
    elsif input == "exit"
      goodbye
    end
  end

  def goodbye
    puts "See you tomorrow for more deals!!!"
  end
end
