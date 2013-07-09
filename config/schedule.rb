env :PATH, ENV['PATH']

#every :day, :at => '03:01am' do  
#  rake 'crawl:crawl_ep',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
#  rake 'crawl:crawl_drama',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
#  rake 'db:data:dump',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
#end

#every :day, :at => '08:01am' do
 # rake 'crawl:crawl_ep',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
#end

#every :day, :at => '11:51am' do
 # rake 'crawl:crawl_ep',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
#end

#every :day, :at => '05:51pm' do
 # rake 'crawl:crawl_ep',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
#end



every :day, :at => '09:01am' do
  rake 'crawl:crawl_youtube',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_taiwan_hearts',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_banana_idol',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_online_show',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:crawl_ck101',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_love_tv',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '09:32am' do
 # rake 'crawl:crawl_youtube',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_taiwan_hearts',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_banana_idol',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_online_show',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_ck101',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_love_tv',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '10:02am' do
 # rake 'crawl:crawl_youtube',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:crawl_taiwan_hearts',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_banana_idol',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_online_show',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_ck101',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_love_tv',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '11:02am' do
 # rake 'crawl:crawl_youtube',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:crawl_taiwan_hearts',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_banana_idol',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_online_show',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_ck101',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_love_tv',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '12:02pm' do
 # rake 'crawl:crawl_youtube',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:crawl_taiwan_hearts',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_banana_idol',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_online_show',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_ck101',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_love_tv',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '13:02pm' do
 # rake 'crawl:crawl_youtube',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:crawl_taiwan_hearts',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_banana_idol',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_online_show',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
 # rake 'crawl:crawl_ck101',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_love_tv',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  #rake 'crawl:update_link_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
