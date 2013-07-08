# encoding: utf-8
class CK101Crawler
  include Crawler

  def parse_eps show
    #get the total page of the show
    fetch show.link
    pages = @page_html.css(".pagination a")
    max = 1
    pages.reverse_each do |page|
      if page.text.to_i > 0
        max = page.text.to_i
        puts "max: " + max.to_s
        break
      end
    end

    show_link = /http:\/\/v.ck101.com\/tv\/showLists\/[0-9]+\//.match(show.link)[0]

    #puts show_link

    (1..max).reverse_each do |index|
      page_link = show_link + index.to_s
      puts page_link

      c = CK101Crawler.new
      c.fetch page_link
      
      nodes = c.page_html.css(".video h3 a")

      nodes.reverse_each do |node|
        title = node.attr("title")
        link = "http://v.ck101.com" + node.attr("href")
        #puts "title: " + title
        #puts "link: " + link

        next if EpV2.find_by_title(title)

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
  end

  def check_source sources
    sources.each do |source|
      "fail" if source.link.is_a?(Nokogiri::XML::Attr)# or source.link.index("ruby")
    end
    "success" 
  end

  def parse_sources link
    puts link

    crawler = CK101Crawler.new
    crawler.fetch link
    sources = []

    #crawler.page_html.css("div[id = youtubeids]").text
    #youtube link
    if crawler.page_html.css("div[id=youtubeids]").present?
      ids = crawler.page_html.css("div[id=youtubeids]").text.split(",")
      ids.each do |id|
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end

        if id.size == 11
          s.link = "http://www.youtube.com/watch?v=" + id.to_s
        else
          #s.link = "http://www.dailymotion.com/video/" + id.to_s
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

end