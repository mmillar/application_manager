class Admin::ProfilesController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"

  # GET /admin/profiles
  # GET /admin/profiles.xml
  def index
    @profiles = Profile.all
    if params[:find_empty] && 
      @find_empty = params[:find_empty]
      @profiles = Profile.where("#{params[:field]} is null OR #{params[:field]} = ''") if params[:field]
    elsif params[:term] && !params[:term].blank?
      @term = params[:term]
      if params[:field] == "status"
        @profiles = []
        Profile.all.each do |profile|
          @profiles << profile if (profile.review && profile.review.status.downcase.include?(params[:term].downcase))
        end
      else
        @profiles = Profile.where("#{params[:field]} = '#{params[:term]}'") if params[:field]
      end
    else
      @profiles = Profile.all
    end
    
    @field = params[:field]

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/profiles/1
  # GET /admin/profiles/1.xml
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/profiles/new
  # GET /admin/profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /admin/profiles
  # POST /admin/profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(admin_profiles_path, :notice => 'Profile was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/profiles/1
  # PUT /admin/profiles/1.xml
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(admin_profiles_path, :notice => 'Profile was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/profiles/1
  # DELETE /admin/profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(admin_profiles_url) }
      format.xml  { head :ok }
    end
  end
end
