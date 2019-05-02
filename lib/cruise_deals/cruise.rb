class CruiseDeals::Cruise
  attr_accessor :name, :price, :nights, :date, :from, :url

  def self.avaliable
    #puts <<-DOC.gsub /^\s*/, ''
    #  1. $519 - 7 nights - Western Mediterranean Cruise Deal
    #  2. $994 - 16 nights - Alaska Cruise Deal
    #DOC

    cruise_1 = self.new
    cruise_1.name = "Western Mediterranean Cruise Deal"
    cruise_1.price = "519"
    cruise_1.nights = "7"
    cruise_1.date = "May 05, 2019"
    cruise_1.from = "Genoa"
    cruise_1.url = "https://www.cruisecritic.com/bargains/"

    cruise_2 = self.new
    cruise_2.name = "Alaska Cruise Deal"
    cruise_2.price = "$994"
    cruise_2.nights = "16"
    cruise_2.date = "May 25, 2019"
    cruise_2.from = "Anchorage"
    cruise_2.url = "https://www.cruisecritic.com/bargains/"

    [cruise_1, cruise_2]
  end

end
