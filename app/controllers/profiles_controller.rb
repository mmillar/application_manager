class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  def new
    @profile = Profile.new
    @districts = ["Toronto", "Vaughan"]
    @key_issues = ["Politics", "Technology", "Business", "Arts"]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    @districts = ["Toronto", "Vaughan"]
    @key_issues = ["Politics", "Technology", "Business", "Arts"]
  end

  def create
    @profile = Profile.new(params[:profile])
    @districts = ["Toronto", "Vaughan"]
    @key_issues = ["Politics", "Technology", "Business", "Arts"]
    @profile.convert("media_formats", params[:profile].delete!("media_formats"))

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @profile = Profile.find(params[:id])
    @districts = ["Toronto", "Vaughan"]
    @key_issues = ["Politics", "Technology", "Business", "Arts"]
    @profile.convert("media_formats", params[:profile].delete("media_formats"))

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
