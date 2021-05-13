class LinksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_link_not_found

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.save ? (redirect_to root_path) : (render :new)
    #@link.save #&& (redirect_to root_path)
  end

  def show
    id = ShortConverter::Decoder.call(params[:id])
    @link = Link.find(id)
    redirect_to @link.url
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def handle_link_not_found
    render :not_found
  end
end
