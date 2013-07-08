# encoding: utf-8
class TaiwanHeartsCrawler
  include Crawler

  def parse_eps show
    #2013 link: http://taiwanhearts.pixnet.net/blog/post/37499644
    #2012 link: http://taiwanhearts.pixnet.net/blog/post/36185100
    #2011 link: http://taiwanhearts.pixnet.net/blog/post/33038174
    #get the total page of the show
    fetch show.link

    nodes = @page_html.css("td a")
    nodes.reverse_each do |node|
      title = node.text
      link = node.attr("href")

      next if EpV2.find_by_title(title)

      ep = EpV2.new
      ep.show_id = show.id
      ep.title = title 
      sources = parse_sources(link)

      sources.each{|s| s.ep_v2_id = ep.id; s.save; } if ep.save
    end

  end

  def parse_sources link
    puts link

    crawler = TaiwanHeartsCrawler.new
    crawler.fetch link
    sources = []

    if crawler.page_html.css(".article-content iframe").present?
      nodes = crawler.page_html.css(".article-content iframe")
      nodes.each do |node|
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end
        #puts node.attr("src")
        s.link = node.attr("src")
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

end