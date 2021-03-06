class UserHomesController < ApplicationController
before_action :set_user_home, except: [:create, :index]

# filter a home + user id
  def show
    @userhome
  end

# show list of each user in that home along with their xp and level for that home
  def index
    @userhomes = UserHome.where(home_id: params[:home_id].to_i)
  end

# user joins a home
  def create
    @userhome = UserHome.new(user_home_params)
    @userhome.user_id = current_user.id
    if @userhome.save
      render :show, status: 201
    else
      render :error
    end
  end

# user leaves a home
  def leave
    authorize @userhome
    @userhome.destroy
  end

  private

  def set_user_home
    begin
      @userhome = UserHome.where(home_id: params[:home_id], user_id: current_user.id)
    rescue
      render :not_found
    end
  end

  def user_home_params
    params.require(:user_homes).permit(:home_id)
  end

end
