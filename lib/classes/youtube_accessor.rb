# encoding: utf-8
require "youtube_it"
class YoutubeAccessor

  def init_client
    @client = YouTubeIt::Client.new
  end

  def load_ytvideos_to_db show
    /youtube.com\/user\/(\w*)/ =~ show.link
    userid = $1

    #puts userid
    #puts show.link
    #The57Watcher list
    if (($1 != nil) and (show.id == 68))
      allresponse = @client.all_playlists(userid)
      allresponse.reverse.each do |all|
        next if EpV2.find_by_title(all.title)
        if all.title.include? show.name
          #p all.title

          ep = EpV2.new
          ep.show_id = show.id
          ep.title = all.title
          dd = all.playlist_id
          ep.save
          playlist = @client.playlist(dd)
          playlist.videos.each do |list|
            if list.title.include? show.name
              #puts list.title

              link = list.player_url
              s = SourceV2.new
              s.ep_v2_id  = ep.id
              source_link = youtube_link(link)
              s.link = source_link
              s.save
            end 
          end               
        end          
      end        
    elsif ($1 != nil)
      response = @client.videos_by(:user => userid )
      ytpage_num = (response.total_result_count / 25) + 1
      (1..ytpage_num).reverse_each do |numm|
        allresponse = @client.videos_by(:user => userid, :page => numm, :per_page => 25)
        allresponse.videos.reverse.each do |all|
          next if EpV2.find_by_title(all.title)
          if all.title.include? show.name
            #p all.title
            ep = EpV2.new
            ep.show_id = show.id
            ep.title = all.title
            ep.save

            #p all.player_url
            s = SourceV2.new
            s.ep_v2_id  = ep.id
            source_link = youtube_link(all.player_url)
            s.link = source_link
            s.save

          elsif ((all.title.include? "電玩瘋") and (show.id == 89))
            #p all.title
            ep = EpV2.new
            ep.show_id = show.id
            ep.title = all.title
            ep.save

            #p all.player_url
            s = SourceV2.new
            s.ep_v2_id  = ep.id
            source_link = youtube_link(all.player_url)
            s.link = source_link
            s.save 
          elsif ((all.title.include? "寶島魚很大") and (show.id == 24))
            #p all.title
            ep = EpV2.new
            ep.show_id = show.id
            ep.title = all.title
            ep.save

            #p all.player_url
            s = SourceV2.new
            s.ep_v2_id  = ep.id
            source_link = youtube_link(all.player_url)
            s.link = source_link
            s.save        
          end
        end
      end  
    end
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