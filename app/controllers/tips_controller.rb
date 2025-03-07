class TipsController < ApplicationController

  def index
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20190810'
    end
      @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

  def create
    resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.body = {"oauth_token": session[:token]}
      req.body = {"v": '20190810'}
      req.body = {"venueId": params[:venue_id]}
      req.body = {"text": params[:tip]}
    end
    redirect_to tips_path
  end
end
