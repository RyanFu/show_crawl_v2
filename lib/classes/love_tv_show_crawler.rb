# encoding: utf-8
require 'open-uri'

class LoveTvShowCrawler
  include Crawler
  def parse_eps show
    #康熙來了: http://2013.vslovetv.com/2013/01/kang-xi-list.html
    fetch show.link
    
    nodes = []
    
    if @page_html.css(".hentry td h3 a").present?
      nodes = @page_html.css(".hentry td h3 a")
    elsif @page_html.css("h3.entry-title a").present?
      nodes = @page_html.css("h3.entry-title a")
    end

    nodes.reverse_each do |node|

      next if node.css("font").present? and node.text.index("2012")

      title = node.text #title of ep

      next if EpV2.find_by_title(title)

      link = node[:href]
      #if "禎甄高興見到你,冰冰好料理,吃飯皇帝大,豬哥會社,浩角正翔起,美麗說達人,大小姐進化論,中國好聲音,亞洲天團爭霸戰,百萬大歌星,非關命運".include? show.name
      #  link = "http://2013.vslovetv.com" + link

      if link.index("vslovetv")
        #puts url
      elsif "禎甄高興見到你,冰冰好料理,吃飯皇帝大,豬哥會社,浩角正翔起,美麗說達人,大小姐進化論,中國好聲音,亞洲天團爭霸戰,百萬大歌星,非關命運".include? show.name
        link = "http://2012.vslovetv.com" + link
      else
        link = "http://2013.vslovetv.com" + link
      end

      #puts link

      ep = EpV2.new
      ep.show_id = show.id
      ep.title = title 
      
      #retry 5 times if fail
      sources = []
      (1..5).each do |i|
        # puts i.to_s
        sources = parse_sources(link)
        break if check_source(sources) == "success"
      end

      sources.each do |source|
        if source.link.is_a?(Nokogiri::XML::Attr)# or source.link.index("ruby")
          sources = link
          break
        end
      end

      sources.each{|s| s.ep_v2_id = ep.id; s.save; } if ep.save
    end 
  end

  def check_source sources
    sources.each do |source|
      "fail" if source.link.is_a?(Nokogiri::XML::Attr)# or source.link.index("ruby")
    end
    "success" 
  end

  def parse_sources link
  	puts link
    #link = "http://2013.vslovetv.com/2013/01/kang-xi-20130101.html"
    crawler = LoveTvShowCrawler.new
    crawler.fetch link
    sources = []
    
    if crawler.page_html.css("div [id='video_ids']").present?
      ids = crawler.page_html.css("div [id='video_ids']").text.split(",")
      #puts crawler.page_html.css("div [id='video_ids']").text
      ids.each do |id|
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end

        if id.index("http") 
          s.link = URI::decode(id)
        elsif id.size == 11
          s.link = "http://www.youtube.com/watch?v=" + id.to_s
        else
          s.link = "http://www.dailymotion.com/video/" + id.to_s
        end  
        sources << s 
      end
    else
      s = SourceV2.new
      if EpV2.all.size > 0
        s.ep_v2_id = EpV2.last.id + 1
      else
        s.ep_v2_id = 0
      end  
      s.link = link
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

  def init_type_v2
  	types = ["綜藝訪談", "美食旅遊", "綜藝搞笑", "女性話題", "政論財經", "娛樂新聞", "音樂選秀", "健康命理", "我們結婚了", "國外其他"]
    
    types.each do |t|
      type = TypeV2.new
      type.name = t
      type.save
    end
  end

  #http://2013.vslovetv.com/2013/01/variety-show-list.html  -> love tv show list
  def parse_shows
    nodes = @page_html.css("td h3 a")

    nodes.each do |node|
      puts node.text
    end
  end

end