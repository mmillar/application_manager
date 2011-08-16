class PagesController < ApplicationController
  def confirm
    if params[:token] && @profile = Profile.find_by_token(params[:token])
      @profile
    else
      render 'public/404.html' and return
    end
  end
end
