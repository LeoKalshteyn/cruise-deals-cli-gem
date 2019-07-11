require 'colorize'

class CruiseDeals::CLI

  def call
    #instance method that loads up the scraper and displays menu
    puts "Loading Cruise Deals..."
    CruiseDeals::Scraper.scrape_cruisecritic
    menu
  end

  def list_cruises(input)
    #instance method which lists the cruises
    puts "Avaliable Cruises:"
    #instance cruises variable is set to the find method in the Cruise class
    @cruises = CruiseDeals::Cruise.find_by_cruise_type(input)
    #enumerator starts at 1 because deals are 1-20
    @cruises.each.with_index(1) do |cruise, i|
        puts "#{i}. #{cruise.name}"
    end
  end

  def search_cruises
    puts "Type your search query"
    input_query = gets.strip
    @cruises = CruiseDeals::Cruise.search_cruises(input_query)
    @cruises.each.with_index(1) do |search_result, i|
        puts "#{i}. #{search_result.name}"
    end
  end

  def menu
    #Instance method that displays the site's details and prompts the user depending on the input.
    input = nil
    puts "Which type of deal would you like more info on?"
    puts "Type in the number of the deal type, (1) All Cruises, (2) Cheapest Cruises, (3) Last Minute Deals or (4) Search Cruise by name. To exit enter (exit)"
    input = gets.strip
    if input == "1"
      list_cruises(input)
      choose_cruise
    elsif input == "2"
      list_cruises(input)
      choose_cruise
    elsif input == "3"
      list_cruises(input)
      choose_cruise
    elsif input == "4"
      list_cruises(input)
      search_cruises
      choose_cruise
    elsif input == "exit"
      goodbye
    else
      puts "Please enter 1-3 for your selection: (1) All Cruises, (2) Cheapest Cruises, or (3) Last Minute Deals"
      menu
    end

  end

  def choose_cruise
    #instance method which contains the structre of the info for a cruise
    input = nil
    puts "Enter the number of the cruise you'd like more info on or enter list to choose a new deal type."
    input = gets.strip.downcase
    #Less/equal to 20 because there are only 20 cruises displayed at one time.
     if input.to_i > 0 && input.to_i <= 20
       #input-1 for the 20th cruise to display because it counts from 0-19
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
