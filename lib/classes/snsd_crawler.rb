# encoding: utf-8
class SNSDCrawler
  include Crawler

  def parse_eps show
    #get the total page of the show
    fetch show.link
    nodes = @page_html.css("div[id=content] .entry span a")
    
    nodes.each do |node|
      link = node.attr("href")
      title = node.css("b b b").text
      #if title != nil and title.size > 1
      puts "title: " + title
      puts "link: " + link
      puts "---------------------------------------"
      #end          
    end

    #html.css("div[id=content] .entry span a")[0].attr("href")


  end

  def parse_sources link
    puts link

    crawler = SNSDCrawler.new
    crawler.fetch link
    sources = []

  end
  

end