require "http"
require "nokogiri"
require "mechanize"
url = "https://bottomlounge.com/events/"

raw_data = HTTP.get(url).to_s

parsed_data = Nokogiri::HTML(raw_data)

### EVENT INFO ###

event_info = parsed_data.css("div.event-bands")
event_info.each do | event |
  if event.css("h2 span:nth-child(2)").text.strip.empty?
    headliner = event.css("h2 span:nth-child(1)").text.strip
    headliner_tr = headliner.gsub("\t\t\t\t\t\t\t\t\t\t", "")

    p "#{headliner_tr}"

  elsif event.css("h2 span:nth-child(3)").text.strip.empty?
    headliner = event.css("h2 span:nth-child(1)").text.strip
    headliner_tr = headliner.gsub("\t\t\t\t\t\t\t\t\t\t", "")
    opener_1 = event.css("h2 span:nth-child(2)").text.strip

    p "#{headliner_tr} with #{opener_1}"

  elsif event.css("h2 span:nth-child(4)").text.strip.empty?
    headliner = event.css("h2 span:nth-child(1)").text.strip
    headliner_tr = headliner.gsub("\t\t\t\t\t\t\t\t\t\t", "")
    opener_1 = event.css("h2 span:nth-child(2)").text.strip
    opener_2 = event.css("h2 span:nth-child(3)").text.strip

    p "#{headliner_tr} with #{opener_1} and #{opener_2}"

  elsif event.css("h2 span:nth-child(5)").text.strip.empty?
    headliner = event.css("h2 span:nth-child(1)").text.strip
    headliner_tr = headliner.gsub("\t\t\t\t\t\t\t\t\t\t", "")
    opener_1 = event.css("h2 span:nth-child(2)").text.strip
    opener_2 = event.css("h2 span:nth-child(3)").text.strip
    opener_3 = event.css("h2 span:nth-child(4)").text.strip

    p "#{headliner_tr} with #{opener_1}, #{opener_2}, and #{opener_3}"
  else
  end
end

### DATE INFO ###

date_info = parsed_data.css("div.schedule-date")
date_info.each do | date |
  date_mo = date.css("span.day").text.strip
  month = date.css("span.dm-m").text.strip
  day = date.css("span.dm-d").text.strip

  p "#{day} #{date_mo} #{month}"
end

### SALE INFO ###

# moves pretty slowly...

client = Mechanize.new
sales_info = parsed_data.css("div.event-bands").css("h2 a")
sales_info.each do | sale |
  sales_url = sale.attr("href")
  sales_page = client.get("#{sales_url}")
  tix = sales_page.css("div.schedule-item.clear a")
  if tix.text.strip == "SOLD OUT!"
    p "true"
  else
    p "false"
  end
end

### IMAGE INFO ###

# moves pretty slowly...

agent = Mechanize.new
image_info = parsed_data.css("div.event-bands").css("h2 a")
image_info.each do | image |
  band_url = image.attr("href")
  band_page = agent.get("#{band_url}")
  pics = band_page.css("div.artist-img img")
  
  p pics.attr("src").value

end

