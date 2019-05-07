class CruiseDeals::Cruise
  attr_accessor :name, :price, :nights, :date, :from, :ship_name, :room_category, :itinerary

  @@all = []

  #Creates objects for scraper
  def initialize(attr_hash)
    @name = attr_hash[:name]
    @nights = attr_hash[:nights]
    @price = attr_hash[:price]
    @date = attr_hash[:date]
    @from = attr_hash[:from]
    @ship_name = attr_hash[:ship_name]
    @room_category = attr_hash[:room_category]
    @itinerary = attr_hash[:itinerary]
    @@all << self
  end

  def self.avaliable
    @@all
  end

  def self.scrape_cruisecritic(url)
    #The scraper itself
    @@all = []
    doc = Nokogiri::HTML(open(url))

    #Iterates through the site's div class pdmli__info
    doc.css(".pdmli__info").each_with_index do |element, i|
      cruise = {}

      # uses xpath to extract the site's info
      cruise[:name] = element.xpath("//div[@class='pdmli__title__destination']")[i].text.lstrip
      cruise[:nights] = element.xpath("//div[@class='pdmli__title__nights']")[i].text.lstrip
      cruise[:ship_name] = element.xpath("//div[@class='ship__name']")[i].text.lstrip
      cruise[:room_category] = element.xpath("//div[@class='ship__cabin']")[i].text.lstrip
      cruise[:price] = element.xpath("//div[@class='pdmli__info__pricing__price']")[i].text.gsub('*', '').lstrip
      cruise[:date] = element.xpath("//div[@class='pdmli__departure-date']")[i].text.lstrip
      cruise[:from] = element.xpath("//div[@class='pdmli__departure-port']")[i].text.gsub('From', '').lstrip
      cruise[:itinerary] = element.xpath("//div[@class='summary-list-lite']")[i].text.gsub(/[\n]+/, "\n").lstrip

      # creates new object in class
      CruiseDeals::Cruise.new(cruise)
    end
  end


end
