class LinksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_link_not_found

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    locals = @link.save ? current_hostname : {}
    render :new, locals: locals
  end

  def show
    @link = Link.find_by_shortcode(params[:shortcode])
    @link.log_visit!
    redirect_to @link.url, status: 301
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def handle_link_not_found
    render :not_found
  end

  def current_hostname
    { hostname: request.host_with_port }
  end
end
