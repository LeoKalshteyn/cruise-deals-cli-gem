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

    cruise.name = doc.xpath("//div[@class='pdmli__title__destination']").text.strip
    cruise.nights = doc.xpath("//div[@class='pdmli__title__nights']").text.strip
    cruise.ship_name = doc.xpath("//div[@class='ship__name']").text.strip
    cruise.room_category = doc.xpath("//div[@class='ship__cabin']").text.strip
    cruise.price = doc.xpath("//div[@class='pdmli__info__pricing__price']").text.strip
    cruise.date = doc.xpath("//div[@class='pdmli__departure']").text.strip
    cruise.from = doc.xpath("//div[@class='pdmli__departure']").text.strip

    cruise
  end


end
