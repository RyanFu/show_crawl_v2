class Api::V1::ShowsController < ApplicationController
  # get the whole show list
  def index
    shows = Show.select("id, is_shown")
    render :json => shows.to_json
  end

  #get one detail show url example /api/v1/numbers  , ex api/v1/1.json
  def show
    eps = Ep.select("id,title,prelink").where("show_id = #{params[:id]}")
    .order("id DESC").paginate(:page => params[:page], :per_page => 20)
    
    #sources = []
    #Source.transaction do 
    #  eps.each do |ep|
    #    source = Source.select("link").find_by_ep_id(ep.id) if ep
    #    sources << source
    #  end
    #end
    

    render :json => eps.to_json
  end

  def update
    device = DeviceWatchInfo.find_by_registration_id_and_show_id(params[:registration_id],params[:id]) 
    if device
      device.watched_ep << params[:ep_id].to_i unless device.watched_ep.include?(params[:ep_id].to_i)
    else device
      device = DeviceWatchInfo.new
      device.show_id = params[:id]
      device.watched_ep = [params[:ep_id].to_i]
      device.registration_id = params[:registration_id]
    end

    if device.save
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{device.errors.messages}")
      render :status=>401, :json=>{:message=> "update fail" }
    end
  end

  def shows_info
    shows_id = params[:id]
    shows_id_array = shows_id.split(",")
    #(id, 節目名稱, type_id, 節目縮圖link)
    shows = Show.select('id, name, type_id, poster_url').where(['id in (?)', shows_id_array])
    render :json => shows.to_json
  end
end