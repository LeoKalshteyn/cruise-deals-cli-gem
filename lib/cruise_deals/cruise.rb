class CruiseDeals::Cruise
  attr_accessor :name, :price, :nights, :date, :from, :ship_name, :room_category

  @@all = []

  def initialize(attr_hash)
    @name = attr_hash[:name]
    @nights = attr_hash[:nights]
    @price = attr_hash[:price]
    @date = attr_hash[:date]
    @from = attr_hash[:from]
    @ship_name = attr_hash[:ship_name]
    @room_category = attr_hash[:room_category]
    @@all << self
  end

  def self.avaliable
    @@all
  end

  def self.scrape_cruisecritic
    @@all = []
    doc = Nokogiri::HTML(open("https://www.cruisecritic.com/bargains/"))
    #binding.binding.pry
    doc.css(".pdmli__info").each_with_index do |element, i|
      cruise = {}

      cruise[:name] = element.xpath("//div[@class='pdmli__title__destination']")[i].text
      cruise[:nights] = element.xpath("//div[@class='pdmli__title__nights']")[i].text
      cruise[:ship_name] = element.xpath("//div[@class='ship__name']")[i].text
      cruise[:room_category] = element.xpath("//div[@class='ship__cabin']")[i].text
      cruise[:price] = element.xpath("//div[@class='pdmli__info__pricing__price']")[i].text
      cruise[:date] = element.xpath("//div[@class='pdmli__departure-date']")[i].text
      cruise[:from] = element.xpath("//div[@class='pdmli__departure']")[i]

      CruiseDeals::Cruise.new(cruise)
    end
  end


end
