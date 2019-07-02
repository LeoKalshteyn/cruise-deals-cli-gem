class CruiseDeals::Scraper

  def self.scrape_cruisecritic
    #The scraper itself
    url_array = ["https://www.cruisecritic.com/bargains/", "https://www.cruisecritic.com/bargains/cheap-cruises/", "https://www.cruisecritic.com/bargains/lastminute.cfm"]
    url_array.each.with_index(1) do |url, j|
      doc = Nokogiri::HTML(open(url))

      #Iterates through the site's div class pdmli_info
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
        cruise[:company_name] = element.xpath("//h2[@class='ship-spotlight__title']")[i].text.gsub(/.* - /, "").lstrip
        cruise[:cruise_type] = j.to_s

        # creates new cruise object in class
        CruiseDeals::Cruise.new(cruise)
      end
    end
  end
end
