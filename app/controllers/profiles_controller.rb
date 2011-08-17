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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  def edit
    @profile = Profile.find(params[:id])

    if params[:token] && params[:token] == @profile.token
      if @profile.review.offer_accepted.blank?
        @profile.review.offer_accepted = DateTime.now
        @profile.review.save
        ProfileMailer.acceptance_confirmation(@profile).deliver
      elsif @profile.picture && @profile.bio
        redirect_to(@profile, :notice => 'confirmed')
      end
    else
      render 'public/404.html' and return
    end
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.convert("media_formats", params[:profile].delete(:media_formats))
    @profile.convert("equipment_access", params[:profile].delete(:equipment_access))
    check_key_issues(@profile, params)
    
    respond_to do |format|
      if @profile.save
        Review.create!(:profile_id => @profile.id)
        #ProfileMailer.initial_application(@profile).deliver
        ProfileMailer.thank_you(@profile).deliver
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
    if params[:token] || params[:profile][:token]
      @profile.picture = params[:profile][:picture] if params[:profile]

      respond_to do |format|
        if @profile.update_attributes(params[:profile])
          format.html {
              redirect_to(@profile, :notice => 'confirmed')
          }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
        end
      end
    else
      render 'public/404.html' and return
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
  
  private
  
    def check_key_issues(profile, params)
      #Check Key Issues other field
      if profile.key_issue_1 == "Other"
        profile.key_issue_1 = params["key_issue_1_other"]
      end
      if profile.key_issue_2 == "Other"
        profile.key_issue_2 = params["key_issue_2_other"]
      end
      if profile.key_issue_3 == "Other"
        profile.key_issue_3 = params["key_issue_3_other"]
      end
    end

end
