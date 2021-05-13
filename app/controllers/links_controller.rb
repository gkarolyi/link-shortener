class LinksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_link_not_found

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    #@link.save ? (redirect_to root_path) : (render :new)
    #@link.save #&& (redirect_to root_path)
    if @link.save
      render @link, locals: { hostname: request.host_with_port }
    else
      render :new
    end
  end

  def show
    id = ShortConverter::Decoder.call(params[:short])
    @link = Link.find(id)
    redirect_to @link.url, status: 301
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def handle_link_not_found
    render :not_found
  end
end
