# encoding: utf-8
require 'gcm'

class GcmSender

  #撥放次數0, 上架時間 1, 2013 2,2012 3 ,2011之前 4
  #type0, 1, 2,3

  def sendMessage type_id, message
    gcm = GCM.new("AIzaSyA5dEbTpjKcNf0d9m14sVmIuuMQtId1vrA")

    Device.select("id, registration_id").find_in_batches( :batch_size => 1000, :conditions => ['id >= ? AND id <= ?', 0, 10000] ) do |devices|

      registration_ids = []  	
  	  devices.each do |device|
        puts device.id
        registration_ids << device.registration_id
      end

      #puts registration_ids

      options = {data: {type_id: type_id, message: message}, collapse_key: "updated_score"}
      response = gcm.send_notification(registration_ids, options)

      #options = {data: {type_id: 1, message: "新劇上架: 原來是美男(台灣版), 跟我說愛我, 美甲店Paris,Dream High 2, 神醫喜來樂傳奇,陸貞傳奇(女相),天才碰麻瓜,活佛濟公, 極道鮮師2,上鎖的房間"}, collapse_key: "updated_score"}
     # response = gcm.send_notification(registration_ids, options)
    end
  end
end