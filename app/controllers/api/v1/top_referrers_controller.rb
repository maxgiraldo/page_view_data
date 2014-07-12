class Api::V1::TopReferrersController < ApplicationController
  respond_to :json
  before_filter :get_top_referrers, :only => [:index]

  def index
    respond_with(@top_referrers)
  end

  private
    def get_top_referrers
      start_day = PageView.select(:created_at).min(:created_at)
      end_day = start_day + (60*60*24*10)

      day_one = end_day.to_date - 5
      day_five = end_day.to_date
      count = 1
      @top_referrers = {}

      while (count <= 5)
        top_ref = []
        PageView.group_and_count(:url).where(:created_at => (day_one + count)..(day_one+count+1)).order(Sequel.desc(:count)).limit(10).each do |result|
            top_ref.push(result)
          end
          top_ref.each do |top_url|
            referrers = []
            PageView.group_and_count{referrer.as(url)}.where(:url => top_url.url).where(:created_at => (day_one + count)..(day_one+count+1)).order(Sequel.desc(:count)).limit(5).each do |referrer|
              referrers.push(referrer)
            end
            top_url[:referrers] = referrers
          end
        @top_referrers[day_one+count] = top_ref
        count += 1
      end

    end

end