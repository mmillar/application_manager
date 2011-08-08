class Admin::ReviewsController < ApplicationController

  def update
    @review = Review.find(params[:id])
    
    if @review.update_attributes(params[:review])
      respond_to do |format|
        format.html { redirect_to admin_profiles_path }
        format.js { render :nothing => true }
      end
    end
  end
end
