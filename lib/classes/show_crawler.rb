# encoding: utf-8
class ShowCrawler
  include Crawler

  def parse_shows
    nodes = @page_html.css("ul.last")
    nodes_childs = nodes.children
    type = Type.new
    nodes_childs.each do |node|
      if node.name == "h2"
        type = Type.new
        type = Type.find_by_name(node.text.strip) if Type.find_by_name(node.text.strip)
        type.name = node.text.strip

        next if ((type.name.index "特別節目") || (type.name.index "完結"))

        type.save
      else
        node = node.css("a")
        if node.present?
          show = Show.new
          puts node.to_html
          show.link = node[0][:href]
          show.name = node.text.strip

          next if ((type.name.index "特別節目") || (type.name.index "完結") || Show.find_by_name(node.text.strip))
          show.type = type
          show.is_shown = false
          show.save
        end
      end
    end
  end

  def parse_eps show

    eps_node = @page_html.css("h3.post-title a")
   
    eps_node.reverse_each do |node|
      title = node.text
      #avoid power sunday 100 percent error
      if show.id == 2
        puts "power skip" 
        next if title.index "Power"
      elsif show.id ==1
        next if title == "康熙來了-20130607-康熙鑑定 傳家寶值多少錢 Kang Xi Lai Le"
      elsif show.id ==77
        next if title == "奔跑吧 孩子們-20130616 Running Man ep120"
      end
      link = node.attr("href")
      puts title
      #check if already in database
      ep = Ep.find_by_title(title)    
      next if ep

      ep = Ep.new
      ep.show_id = show.id
      ep.title = title 
      
      sources = parse_sources(link)
      sources.each{|s| s.ep = ep; s.save; } if ep.save

    end
  end

  def parse_sources link
    puts link
    crawler = ShowCrawler.new
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
    #
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

      s = Source.new
      #s.ep_id = ep.id
      if Ep.all.size > 0
        s.ep_id = Ep.last.id + 1
      else
        s.ep_id = -1
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

  def instant_parse_source ep
    ep.sources.each{|s| s.delete}

    if @page_html.css("#video_ids").present?
      id_text = @page_html.css("#video_ids").text
      ids = id_text.split(",")
      ids.each do |id|
        source = Source.new
        source.ep = ep
        source.link = generate_youtube_or_dailymotion(id)
        source.save
        puts "ids source: #{source.link} #{source.ep.title}"
      end
      return
    end
    if @page_html.css("iframe").present?
      nodes = @page_html.css("iframe")
      nodes.each do |node|
        src = node[:src]
        if (src.index("youtube") || src.index("dailymotion"))
          source = Source.new
          source.ep = ep
          source.link = youtube_link(src)
          source.save
          puts "iframe source: #{source.link} #{source.ep.title}"
        end
      end
    end
    if @page_html.css("object").present?
      nodes = @page_html.css("object")
      nodes.each do |node|
        data = node[:data]
        if data.index("youtube")
          source = Source.new
          source.ep = ep
          source.link = youtube_link(src)
          source.save
          puts "object source: #{source.link} #{source.ep.title}"
        end
      end
    end
  end

  def instant_parse_source_2 ep
    ep.source_v2s.each{|s| s.delete}

    if @page_html.css("#video_ids").present?
      id_text = @page_html.css("#video_ids").text
      ids = id_text.split(",")
      ids.each do |id|
        source = SourceV2.new
        source.ep_v2 = ep
        source.link = generate_youtube_or_dailymotion(id)
        source.save
     #   puts "ids source: #{source.link} #{source.ep.title}"
      end
      return
    end
    if @page_html.css("iframe").present?
      nodes = @page_html.css("iframe")
      nodes.each do |node|
        src = node[:src]
        if (src.index("youtube") || src.index("dailymotion"))
          source = SourceV2.new
          source.ep_v2 = ep
          source.link = youtube_link(src)
          source.save
        #  puts "iframe source: #{source.link} #{source.ep.title}"
        end
      end
    end
    if @page_html.css("object").present?
      nodes = @page_html.css("object")
      nodes.each do |node|
        data = node[:data]
        if data.index("youtube")
          source = SourceV2.new
          source.ep_v2 = ep
          source.link = youtube_link(src)
          source.save
        #  puts "object source: #{source.link} #{source.ep.title}"
        end
      end
    end

    if @page_html.css(".myYoutubePlaylist_clearer script").present?
      nodes = @page_html.css(".myYoutubePlaylist_clearer script")

      nodes.each do |node|
        video_str = node.text
        ids_str = /myYoutubePlaylist_dl\('(.*)','myYoutubePlaylist_YoutubePlaylist/ .match(video_str)
        ids = $1.split(", ")
        
        ids.each do |id|
          s = SourceV2.new
          if EpV2.all.size > 0
            s.ep_v2_id = EpV2.last.id + 1
          else
            s.ep_v2_id = 0
          end
          s.link = "http://www.youtube.com/watch?v=" + id.to_s
        #  sources << s
          s.save 
        end
      end
    end 

    if @page_html.css(".wp-tab-content-wrapper iframe").present?    
      nodes = @page_html.css(".wp-tab-content-wrapper iframe")
      nodes.each do |node|
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end
        s.link = node.attr("src").to_s
       # sources << s
        s.save
      end
    end

    if @page_html.css(".entry p iframe").present?
      nodes = @page_html.css(".entry p iframe")
      nodes.each do |node|
        #puts node.attr("src")
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end

        s.link = node.attr("src").to_s
        
       # sources << s
        s.save 
      end
    end  
   



  end
end