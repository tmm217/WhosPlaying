task(:blounge_shows => :environment) do
  require "http"
  require "nokogiri"
  require "mechanize"
  
  url = "https://bottomlounge.com/events/"
  raw_data = HTTP.get(url).to_s
  parsed_data = Nokogiri::HTML(raw_data)

  parsed_data.css("div.schedule-item.clear").each do | show |
    client = Mechanize.new
    agent = Mechanize.new

    date_no = show.css("div.schedule-date").css("span.day").text.strip
    month = show.css("div.schedule-date").css("span.dm-m").text.strip
    day = show.css("div.schedule-date").css("span.dm-d").text.strip

    pic_url = show.css("div.event-bands").css("h2 a").attr("href")
    band_page = agent.get("#{pic_url}")
    image = band_page.css("div.artist-img img").attr("src").value

    sale = band_page.css("div.schedule-item.clear a").text.strip

    headliner = show.css("div.event-bands").css("h2 span:nth-child(1)").text.strip
    headliner_tr = headliner.gsub("\t\t\t\t\t\t\t\t\t\t", "")
    opener_1 = show.css("div.event-bands").css("h2 span:nth-child(2)").text.strip
    opener_2 = show.css("div.event-bands").css("h2 span:nth-child(3)").text.strip
    opener_3 = show.css("div.event-bands").css("h2 span:nth-child(4)").text.strip
    opener_4 = show.css("div.event-bands").css("h2 span:nth-child(5)").text.strip

    s = Show.new
    s.host_id = 2
    s.show_date = "#{day} #{date_no} #{month}"
    s.show_image = "#{image}"
    if opener_1.empty?
      s.show_bands = "#{headliner_tr}"
    elsif opener_2.empty?
      s.show_bands = "#{headliner_tr} with #{opener_1}"
    elsif opener_3.empty?
      s.show_bands = "#{headliner_tr} with #{opener_1} and #{opener_2}"
    elsif opener_4.empty?
      s.show_bands = "#{headliner_tr} with #{opener_1}, #{opener_2}, and #{opener_3}"
    end
    if sale == "SOLD OUT!"
      s.is_soldout = "true"
    else
      s.is_soldout = "false"
    end
    s.save
  end
end

# scheduling will be done on Heroku --> add-on called "Scheduler"
# will give it a command-line prompt ex. rails scrape_metro
# put that into the heroku scheduler; most frequently you can do it is 10 minutes
# once every day, you can write it in the rake task
# calling rake task inside another rake task: could make methods and pull into a single file or one encompassing one rake task
# one thing I could do is:
  # db:migrate --> Rake::Task["db:migrate"].invoke
  # rails scrape_all_venues would call a task with this
  # something more familiar: call class methods on the venue model (e.g., oldest director self.oldest and define the method)
  # director.oldest and that would run the method
  # in venue you could write a class method to scrap these sites; one for metro, one for another and write the logic for each place
  # in rake task, it's a matter of calling the class methods in each of those
  # writing the class methods instead of rake tasks gives me more familiarity; have one rake tasks that would call all the scrapping methods and then have scrap tasks that call specific 