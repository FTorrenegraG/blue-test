class PageUrlsController < ApplicationController
  def create
    page_short = PageUrlShort.find_or_create_by(
      origin_url: page_params[:url]
    )

    if page_short
      render json: page_short, status: :ok
      return
    end

    unless page_short.save
      render json: page_short.errors, status: 422
      return
    end

    render json: page_short, status: :ok
  end

  def index

    render json: PageUrlShort.order_by_view_counter.limit(100), status: :ok

  end

  def show
    page_short = PageUrlShort.find_by_redirect_url(params[:id].html_safe)
    page_short.sum_view_counter
    render json: page_short, only: :origin_url, status: :ok
  end

  private

  def page_params
    params.permit(
      :url
    )
  end
end
