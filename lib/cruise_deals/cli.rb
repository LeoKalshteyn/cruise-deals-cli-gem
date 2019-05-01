# CLI Controller
class CruiseDeals::CLI

  def call
    list_cruises
    menu
    goodbye
  end

  def list_cruises
    puts "Cruise Deals:"
    @cruises = CruiseDeals::Cruise.avaliable
  end

  def menu
    input = nil
    while input != "exit"
      puts "enter the number of the cruise or type exit or list to see deals again"
      input = gets.strip.downcase
      case input
      when "1"
        puts "more info on cruise 1"
      when "2"
        puts "more info on cruise 2"
      when "list"
        list_cruises
      else
        puts "Not sure what you want, type list or exit"
      end
    end
  end

  def goodbye
    puts "see you later"
  end


end
