class Api::V1::TopUrlsController < ApplicationController
  respond_to :json
  before_filter :get_top_urls, :only => [:index]

  def index
    respond_with(@top_urls)
    # render :json => @top_urls, :status => 200
  end

  private
    def get_top_urls
      start_day = PageView.select(:created_at).order(:created_at).first
      end_day = start_day.created_at + (60*60*24*10)
      start_day = start_day.created_at.to_date

      day_one = end_day.to_date - 5
      day_five = end_day.to_date
      count = 1
      @top_urls = {}

      while (count <= 5)
        result = []
        PageView.group_and_count(:url).where(:created_at => (day_one + count)..(day_one+count+1)).each do |x|
            result.push(x)
          end
        @top_urls[day_one+count] = result
        count += 1
      end
    # rescue Sequel::Error::RecordNotFound
    #   error = { :error => "Couldn't find page_views"}
    #   respond_with(error, :status => 404)

    end

end