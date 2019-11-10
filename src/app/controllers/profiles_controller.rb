class ProfilesController < ApplicationController
  before_action :authenticate_runner!

  #Calling on the params of specific profile parameters if present to be displayed in the view
  def index
    @profile = Profile.exclude_blank_profiles.where.not(id: current_runner.profile.id)
    if params[:q].present?
      p params[:q][:username_eq]
      @profile = @profile.where(:pace => params[:q][:pace_eq]) if params[:q][:pace_eq].present?
      @profile = @profile.where(:gender => params[:q][:gender_eq]) if params[:q][:gender_eq].present?
      @profile = @profile.where(:age => params[:q][:age_eq]) if params[:q][:age_eq].present?
      @profile = @profile.where(:runningregion => params[:q][:runningregion_eq]) if params[:q][:runningregion_eq].present?
      @profile = @profile.where("username ILIKE ?", "%#{params[:q][:username_eq]}%") if params[:q][:username_eq].present?
    else
      params[:q] = { :pace_eq => "", :gender_eq => "", :age_eq => "", :runningregion_eq => "", :username_eq => "" }
    end
    # @profile = Profile.all
    # if params[:q].present?
    #   p params[:q]
    #   @profile = Profile.all
    # end
    # @search = Profile.search(params[:q])
  end

    #finding the correct profile to be displayed
  def show
    @profile = Profile.find(params[:id])
  end

  def delete
    render(:delete)
    destroy
  end
  #removing a profile from the database (done by the admin)
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    #currently unused method to allow specific access that could be added to a before action.
  def authorize
    if current_user != @profile.username
      flash[:alert] = "Cannot access this profile"
      redirect_to root_path
    end
  end

    #sanitize parameters 
  def profile_params
    params.require(:profile).permit(:username, :age, :gender, :pace, :image)
  end
end
