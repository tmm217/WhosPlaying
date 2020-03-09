# namespace(:dev) do
#   desc "Fill the database tables with some dummy data"
#     task({ :prime => :environment}) do

task(:metro_shows => :environment) do
  require "http"
  require "nokogiri"
  
  url = "https://metrochicago.com/events/"
  raw_data = HTTP.get(url).to_s
  parsed_data = Nokogiri::HTML(raw_data)

  parsed_data.css("div.rhino-event-wrapper").each do | show |  
    show.css("div.rhino-event-datebox").each do | date |
  end  

  ### EVENT INFO ###
  event_info = parsed_data.css("div.rhino-event-info")
  event_info.each do | event |
    if event.css("h3.rhino-event-subheader").inner_text.empty?
      headliner = event.css("h2.rhino-event-header a[title]").text.strip
      show = Show.new
      show.show_bands = "#{headliner}"

      if Show.where(:show_bands => "#{headliner}").first == nil
      show.save
      end
    else
      headliner = event.css("h2.rhino-event-header a[title]").text.strip
      openers = event.css("h3.rhino-event-subheader").inner_text
      
      show = Show.new
      show.show_bands = "#{headliner} with #{openers}"
      if Show.where(:show_bands => "#{headliner} with #{openers}").first == nil
        show.save
      end
      
    end
  end

  # count = Show.count
  # ### DATE INFO ###
  # date_info = parsed_data.css("div.rhino-event-datebox")
  # date_info.each do | date |
    
  #   date_no = date.css(".rhino-event-datebox-date p").inner_text
  #   month = date.css(".rhino-event-datebox-month p").inner_text
  #   day = date.css(".rhino-event-datebox-day p").inner_text

  #   p "#{day} #{date_no} #{month}"
  # end

  # ### SALES INFO ###
  # sale_info = parsed_data.css("div.rhino-event-list-cta")
  # sale_info.each do | sale |
  #   if sale.css("span").inner_text == "Sold Out"
  #     p "true"
  #   else
  #     p "false"
  #   end
  # end

#   ### IMAGE INFO ###
#   parsed_data.css("div.tribe-events-event-image img").each do |image| 
#     p image.attr("src")
#   end
 end
