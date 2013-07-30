# encoding: utf-8
namespace :crawl do
  task :crawl_show => :environment do
    url = "http://www.xn--fhqp31hmre.tv/2012/12/arts-online.html"
    crawler = ShowCrawler.new
    crawler.fetch url
    crawler.parse_shows
  end

  task :crawl_ep => :environment do
    Show.all.each do |show|
      crawler = ShowCrawler.new
      crawler.fetch show.link + "?max-results=100"
      crawler.parse_eps(show)
    end
    update_link
  end

  task :update_link => :environment do
    puts "add prelink"
    Ep.all.each do |ep| 
      source = Source.select("link").find_by_ep_id(ep.id) if ep
      ep.prelink = source.link if source
      #puts "prelink: " + ep.prelink if source
      ep.save
    end
  end

  def update_link
    puts "add prelink"
    Ep.all.each do |ep| 
      source = Source.select("link").find_by_ep_id(ep.id) if ep
      ep.prelink = source.link if source
      #puts "prelink: " + ep.prelink if source
      ep.save
    end
  end

  task :crawl_youtube => :environment do
    c = YoutubeAccessor.new
    ShowV2.all.each do |show|
      if show.link.index("youtube")
        puts show.name
        c.init_client
        c.load_ytvideos_to_db show
      end
    end
    update_link_v2
  end 

  task :crawl_taiwan_hearts => :environment do
    c = TaiwanHeartsCrawler.new
    ShowV2.all.each do |show|
      if show.link.index("taiwanhearts")
        puts show.name
        c.parse_eps show
      end
    end
    update_link_v2
  end

  task :crawl_banana_idol => :environment do
    c = BananaIdolCrawler.new
    ShowV2.all.each do |show|
      skipids = [113,115,116,117,118,120,121,122,123]
      next if skipids.include? show.id
      if show.link.index("bananaidolshow")
        puts show.name
        c.parse_eps show
      end
    end
    update_link_v2
  end

  task :crawl_online_show => :environment do
    c = OnlineWatchShowCrawler.new
    ShowV2.all.each do |show|
      if show.link.index("fhqp31hmre")
        puts show.name
        c.parse_eps show
      end
    end
    update_link_v2
  end

  task :crawl_ck101 => :environment do
    c = CK101Crawler.new
    ShowV2.all.each do |show|
      if show.link.index("ck101")
        puts show.name
        c.parse_eps show
      end
    end
    update_link_v2
  end

  task :crawl_love_tv => :environment do
    c = LoveTvShowCrawler.new
    ShowV2.all.each do |show|
      if show.link.index("vslovetv")
        puts show.name
        c.parse_eps show
      end
    end
    update_link_v2
  end

  task :update_link_v2 => :environment do
    puts "add prelink"
    EpV2.all.each do |ep| 
      source = SourceV2.select("link").find_by_ep_v2_id(ep.id) if ep
      ep.prelink = source.link if source
      #puts "prelink: " + ep.prelink if source
      ep.save
    end
  end

  def update_link_v2
    puts "add prelink"
    EpV2.all.each do |ep| 
      source = SourceV2.select("link").find_by_ep_v2_id(ep.id) if ep
      ep.prelink = source.link if source
      #puts "prelink: " + ep.prelink if source
      ep.save
    end
  end
end

