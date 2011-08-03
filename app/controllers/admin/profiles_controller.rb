class Admin::ProfilesController < ApplicationController
  before_filter :authenticate_user!

  # GET /admin/profiles
  # GET /admin/profiles.xml
  def index
    @admin_profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_profiles }
    end
  end

  # GET /admin/profiles/1
  # GET /admin/profiles/1.xml
  def show
    @admin_profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_profile }
    end
  end

  # GET /admin/profiles/new
  # GET /admin/profiles/new.xml
  def new
    @admin_profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_profile }
    end
  end

  # GET /admin/profiles/1/edit
  def edit
    @admin_profile = Profile.find(params[:id])
  end

  # POST /admin/profiles
  # POST /admin/profiles.xml
  def create
    @admin_profile = Profile.new(params[:admin_profile])

    respond_to do |format|
      if @admin_profile.save
        format.html { redirect_to(@admin_profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @admin_profile, :status => :created, :location => @admin_profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/profiles/1
  # PUT /admin/profiles/1.xml
  def update
    @admin_profile = Admin::Profile.find(params[:id])

    respond_to do |format|
      if @admin_profile.update_attributes(params[:admin_profile])
        format.html { redirect_to(@admin_profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/profiles/1
  # DELETE /admin/profiles/1.xml
  def destroy
    @admin_profile = Admin::Profile.find(params[:id])
    @admin_profile.destroy

    respond_to do |format|
      format.html { redirect_to(admin_profiles_url) }
      format.xml  { head :ok }
    end
  end
end
