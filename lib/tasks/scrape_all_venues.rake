task(:scrape_all => :environment) do
  Rake::Task["metro_shows"].invoke
  Rake::Task["blounge_shows"].invoke
end