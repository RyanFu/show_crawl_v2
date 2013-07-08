class Api::V2::ShowsController < ApplicationController
  # get the whole show list
  def index
    shows = ShowV2.select("id, is_shown")
    render :json => shows.to_json
  end

  #get one detail show url example /api/v2/numbers  , ex api/v2/1.json
  def show
    eps = EpV2.select("id,title,prelink").where("show_id = #{params[:id]}")
    .order("id DESC").paginate(:page => params[:page], :per_page => 20)

    render :json => eps.to_json
  end

  def shows_info
    shows_id = params[:id]
    shows_id_array = shows_id.split(",")
    #(id, 節目名稱, type_id, 節目縮圖link)
    shows = ShowV2.select('id, name, type_id, poster_url').where(['id in (?)', shows_id_array])
    render :json => shows.to_json
  end

end
