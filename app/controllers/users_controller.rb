class UsersController < ApplicationController
before_action :set_user, except: [:create, :new, :index]
before_action :set_homes, except: [:create, :new, :index, :destroy]
  def show
    @total_exp = Chore.where(user_id: params[:id]).pluck(:value).sum
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    begin
      @user = User.find(params[:id])
    rescue
      render 'not_found'
    end
  end

  def set_homes
    begin
      @homes = UserHome.where(user_id: params[:id])
    rescue
      render 'not_found'
    end
  end

end