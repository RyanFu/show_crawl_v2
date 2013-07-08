class EpsController < ApplicationController

  def index
    @eps = Ep.paginate(:page => params[:page], :per_page => 20).order("id desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Eps }
    end
  end

  def search
    search_text = params[:search].strip
    @eps = Ep.where(["title like ?", "%#{search_text}%"]).order("id DESC")
  end

  def update_ep
    ep = Ep.find(params[:ep_id])
    url = params[:url]
    crawl = ShowCrawler.new
    crawl.fetch url
    crawl.instant_parse_source ep
    ep = Ep.find(params[:ep_id])
    ep.prelink = ep.sources[0].link if ep.sources.present?
    ep.save
    redirect_to :action => 'show', :id => ep.id
  end

  def show
    @ep = Ep.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ep }
    end
  end

  def edit
    @ep = Ep.find(params[:id])
  end

  def destroy
    @ep = Ep.find(params[:id])
    @ep.destroy
    redirect_to :controller => 'eps', :action => 'index'
  end
end
