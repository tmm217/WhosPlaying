require "http"
require "nokogiri"
url = "https://lh-st.com/?pag=1"

raw_data = HTTP.get(url).to_s

parsed_data = Nokogiri::HTML(raw_data)

## EVENT INFO ###
event_info = parsed_data.css("div.card-body")
event_info.each do | event |
  if event.css("div.additionalArtists span.additionalArtistName:nth-child(1)").text.strip.empty?
    headliner = event.css("h4").text.strip

    p "#{headliner}"
  else
    headliner = event.css("h4").text.strip
    openers = event.css("div.additionalArtists span.additionalArtistName:nth-child(1)").text.strip
    if openers == "Guest"
      p "#{headliner}"
    else
      p "#{headliner} with #{openers}"
    end
  end
end

## DATE INFO ###

# date_info = parsed_data.css("div.card-body")
# date_info.each do | date |
#   dateline = date.css("div.showDateHidden").text.strip

#   p "#{dateline}"
# end

## SALE INFO ###

# website always contains an element <div class="sold-out">Sold Out</div> --> how do you get around that?
# sale_info = parsed_data.css("div.show-banner-tag")
# sale_info.each do | sale |
#   if sale.css("div.sold-out").text.strip.empty?
#     p "false"
#   else
#     p "true"
#   end
# end

### IMAGE INFO ###
# image_info = parsed_data.css("div.image-container div.content")
# image_info.css("a img").each do |image| 
#   p image.attr("data-image-url")
# end


