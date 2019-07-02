class CruiseDeals::Cruise
  #method that defines getter and setter methods for instance variables
  attr_accessor :name, :price, :nights, :date, :from, :cruise_type, :ship_name, :room_category, :itinerary, :company_name

  #class variable array
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
    @company_name = attr_hash[:company_name]
    @cruise_type = attr_hash[:cruise_type]
    @@all << self
  end

  def self.avaliable
    @@all
  end

  #class method that iterates through @@all for all cruises where the cruise type equals input
  def self.find_by_cruise_type(input)
   avaliable.select do |cruise|
      cruise.cruise_type == input
    end
  end


end
