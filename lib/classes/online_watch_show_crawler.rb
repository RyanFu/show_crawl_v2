# encoding: utf-8
class OnlineWatchShowCrawler
  include Crawler

   def parse_eps show
   	fetch show.link

    eps_node = @page_html.css("h3.post-title a")
   
    eps_node.reverse_each do |node|
      title = node.text
      link = node.attr("href")
      puts title
      #check if already in database
      ep = EpV2.find_by_title(title)    
      next if ep

      ep = EpV2.new
      ep.show_id = show.id
      ep.title = title 
      
      sources = parse_sources(link)
      sources.each{|s| s.ep_v2_id = ep.id; s.save; } if ep.save

    end
  end

  def parse_sources link
    puts link
    crawler = OnlineWatchShowCrawler.new
    crawler.fetch link
    #if it is youtube link
    if crawler.page_html.css(".entry-content iframe").present?
      source_node = crawler.page_html.css(".entry-content iframe")
    #if it is a dailymotion link 
    elsif crawler.page_html.css("embed").present?  
      source_node = crawler.page_html.css("embed") 
    #if it is youku link
    elsif crawler.page_html.css(".entry-content param[name='flashvars']").present?  
      source_node = crawler.page_html.css(".entry-content param[name='flashvars']")
    end
    #http://v.youku.com/v_show/id_XNDg3ODYwMjE2.html?f=18696078
    #source_node = @page_html.css("iframe[height=440]")
    #puts source_node
    sources = []
    source_node.each do |node|
      if crawler.page_html.css(".entry-content param[name='flashvars']").present?
        source = node.attr("value")
      else
        source = node.attr("src")
      end

      source = youtube_link(source)

      puts source

      s = SourceV2.new
      #s.ep_id = ep.id
      if EpV2.all.size > 0
        s.ep_v2_id = EpV2.last.id + 1
      else
        s.ep_v2_id = 0
      end      
      s.link = source
      sources << s  
    end
    sources
  end

  def youtube_link link
    #http://www.youtube.com/embed/37PMB8FDjM4?version=3&amp;autoplay=0&amp;iv_load_policy=3&amp;cc_load_policy=1&amp;rel=0&amp;showinfo=0&amp;modestbranding=1&amp;theme=light
    if /youtube.com\/watch\?v=(.{11})/ =~ link
      "http://www.youtube.com/watch?v=" + $1
    elsif /www.youtube.com\/embed\/(.{11})/ =~ link
      "http://www.youtube.com/watch?v=" + $1
    elsif /www.youtube.com\/v\/(.{11})/ =~ link
      "http://www.youtube.com/watch?v=" + $1
    elsif /ideoIDS=(.{13})/ =~ link
      "http://m.youku.com/smartphone/detail?vid=" + $1
    else
      link
    end
  end

  def generate_youtube_or_dailymotion id
    if id.length == 11
      "http://www.youtube.com/watch?v=#{id}"
    else
      "http://www.dailymotion.com/embed/video/#{id}?hideInfos=1"
    end
  end

end