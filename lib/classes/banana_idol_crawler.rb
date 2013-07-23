# encoding: utf-8
class BananaIdolCrawler
  include Crawler

  def parse_eps show
    fetch show.link

    type = TypeV2.find_by_name("我們結婚了")

    #we married
    if show.type_id == type.id
      puts show.name
      #世界版
      if show.name.index("世界版")

        nodes = @page_html.css(".entry h4")
        nodes.each do |node|
          if node.previous_element.present? and node.previous_element.css("strong").present?
            if node.previous_element.css("strong").text == "玉澤演 鬼鬼 Lists"
              #eps = html.css(".entry h4")[2].css("li a")[0]
              eps = node.css("li a")

              eps.reverse_each do |ep|
                title = "鬼澤夫婦_" + ep.text
                link = ep.attr("href")
                #puts "ep title: " + title
                #puts "ep link : " + link
                next if EpV2.find_by_title(title)

                ep = EpV2.new
                ep.show_id = show.id
                ep.title = title 
                #retry 5 times if fail
                sources = []
                  (1..20).each do |i|
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
                break

              end

            elsif node.previous_element.css("strong").text == "洪基 藤井美菜 Lists"
              eps =node.css("li a")

              eps.reverse_each do |ep|
                title = "彩虹夫婦_" + ep.text
                link = ep.attr("href")
                #puts "ep title: " + title
                #puts "ep link : " + link
                next if EpV2.find_by_title(title)

                ep = EpV2.new
                ep.show_id = show.id
                ep.title = title 
                #retry 5 times if fail
                sources = []
                (1..20).each do |i|
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
        end  
      
      elsif show.name.index("第一季")
        ep_hash = {}
        ep_hash["我們結婚了 S1 EP1-5 We Got Married 第1-5回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep1-8-married-%E7%AC%AC1-8%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP6-10 We Got Married 第6-10回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep6-10-married-%E7%AC%AC6-10%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP11-15 We Got Married 第11-15回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep11-15-married-%E7%AC%AC11-15%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP16-20 We Got Married 第16-20回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep16-20-married-%E7%AC%AC16-20%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP21-25 We Got Married 第21-25回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep21-25-married-%E7%AC%AC21-25%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP26-30 We Got Married 第26-30回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep26-30-married-%E7%AC%AC26-30%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP31-35 We Got Married 第31-35回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep31-35-married-%E7%AC%AC31-35%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP36-40 We Got Married 第36-40回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep31-35-married-%E7%AC%AC31-35%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP41-45 We Got Married 第41-45回"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep41-45-married-%E7%AC%AC41-45%E5%9B%9E/"
        ep_hash["我們結婚了 S1 EP51-55 We Got Married 第51-55回 The End"] = "http://www.bananaidolshow.com/Koreanshows/%E6%88%91%E5%80%91%E7%B5%90%E5%A9%9A%E4%BA%86-s1-ep51-55-married-%E7%AC%AC51-55%E5%9B%9E/"
        
        ep_hash.each do |key, value|
          #puts "ep title: " + key
          #puts "ep link : " + value
          title = key
          link = value
          next if EpV2.find_by_title(title)

          ep = EpV2.new
          ep.show_id = show.id
          ep.title = title 
          #retry 5 times if fail
          sources = []
          (1..20).each do |i|
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
        
      else

        titles = @page_html.css("div[id=wp-accordion-1] h3")
        
        index = 0

        titles_hash = {} 

        titles.each do |title|
          #puts title.text
          title_key = title.text.sub(' ','')
          #puts title_key
          titles_hash[title_key] = index
          
          index += 1
        end

        ep_index = titles_hash[show.name]
        eps_nodes =  @page_html.css(".wp-tab-content-wrapper h4 ul")[ep_index]
        eps = eps_nodes.css("li a")

        eps.reverse_each do |ep|
          ep_title =  show.name + "_" + ep.text
          link = ep.attr("href")

          next if EpV2.find_by_title(ep_title)

          ep = EpV2.new
          ep.show_id = show.id
          ep.title = ep_title
          #retry 5 times if fail
          sources = []
          (1..20).each do |i|
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
          #puts "ep title: " + ep_title
          #puts "ep link : " + ep.attr("href")
        end

      end
      
    #without we married
    else
      #nodes = @page_html.css(".entry h4 ul li a")  
      nodes = @page_html.xpath("//*[@id='content']/div[1]/div/div[1]/div/h4[2]/ul/li")

      nodes.reverse_each do |node|
        title = node.css("a").text
        link = node.css("a").attr("href")

        next if EpV2.find_by_title(title)

        ep = EpV2.new
        ep.show_id = show.id
        ep.title = title 
        

        #retry 5 times if fail
        sources = []
        (1..20).each do |i|
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

    crawler = BananaIdolCrawler.new
    crawler.fetch link
    sources = []

    if crawler.page_html.css(".entry p iframe").present?
      nodes = crawler.page_html.css(".entry p iframe")
      nodes.each do |node|
        #puts node.attr("src")
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end

        s.link = node.attr("src").to_s
        
        sources << s 
      end

    elsif crawler.page_html.css(".myYoutubePlaylist_clearer script").present?
      nodes = crawler.page_html.css(".myYoutubePlaylist_clearer script")

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
          sources << s 
        end
      end

    elsif crawler.page_html.css(".entry embed").present?
      nodes = crawler.page_html.css(".entry embed")
      nodes.each do |node|
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end
        s.link = node.attr("src").to_s
        sources << s
      end

    elsif crawler.page_html.css(".wp-tab-content-wrapper iframe").present?
      nodes = crawler.page_html.css(".wp-tab-content-wrapper iframe")
      nodes.each do |node|
        s = SourceV2.new
        if EpV2.all.size > 0
          s.ep_v2_id = EpV2.last.id + 1
        else
          s.ep_v2_id = 0
        end
        s.link = node.attr("src").to_s
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