class EpV2sController < ApplicationController

  def index
    @eps = EpV2.paginate(:page => params[:page], :per_page => 20).order("id desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Eps }
    end
  end

  def search
    search_text = params[:search].strip
    @eps = EpV2.where(["title like ?", "%#{search_text}%"]).order("id DESC")
  end

  def show
    @ep = EpV2.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ep }
    end
  end

  def destroy
    @ep = EpV2.find(params[:id])
    @ep.destroy
    redirect_to :controller => 'ep_v2s', :action => 'index'
  end  

  def edit
    @ep = EpV2.find(params[:id])
  end  


  def update_ep
    ep = EpV2.find(params[:ep_v2_id])
    url = params[:url]
    crawl = ShowCrawler.new
    crawl.fetch url
    crawl.instant_parse_source_2 ep
    ep = EpV2.find(params[:ep_v2_id])
    ep.prelink = ep.source_v2s[0].link if ep.source_v2s.present?
    ep.save
    redirect_to :action => 'show', :id => ep.id
  end  

end
