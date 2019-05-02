class CruiseDeals::Cruise
  attr_accessor :name, :price, :nights, :date, :from, :ship_name, :room_category

  def self.avaliable
    # scrape CruiseCritic and return cruise deals
    self.scrape_cruises
  end

  def self.scrape_cruises
    # Go to CruiseCritic, get the details and print
    cruises = []
    cruises << self.scrape_cruisecritic

    cruises
  end

  def self.scrape_cruisecritic
    doc = Nokogiri::HTML(open("https://www.cruisecritic.com/bargains/"))
    #binding.binding.pry
    cruise = self.new

    cruise.name = doc.search("pdmli__title__destination").text.strip
    cruise.nights = doc.search("pdmli__title__nights").text.strip
    cruise.ship_name = doc.search("ship__name").text.strip
    cruise.room_category = doc.search("ship__cabin").text.strip
    cruise.price = doc.search("pdmli__info__pricing__price").text.strip
    cruise.date = doc.search("pdmli__departure-date").text.strip
    cruise.from = doc.search("pdmli__departure-port").text.strip

    cruise
  end


end
