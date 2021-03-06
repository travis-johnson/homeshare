class UsersController < ApplicationController
before_action :set_user, except: [:create, :index]
before_action :set_homes, except: [:create, :index, :destroy]

  def show
    calc_total
    @user_level = calc_exp(@total_exp)
    @user_percent = @percent
    @user_level = @level
    home_method
    @home_level = calc_exp(@home_exp)
    @home_percent = @percent
    @home_level = @level
  end

  def index
    @users = User.all
  end

  def destroy
    authorize @user
    @user.destroy
  end

  def update
    if @user.update(user_params)
      render :show, status: 201
    else
      render :error
    end
  end

  def me
    show
  end

  private

  def set_user
    begin
      @user = current_user
    rescue
      render :not_found
    end
  end

  def set_homes
    begin
      @homes = UserHome.where(user_id: current_user.id)
    rescue
      render :not_found
    end
  end

  def home_method
    @home_exp = Chore.joins(:home).where(chore_completer_id: current_user.id, completed: true).pluck(:chore_xp).sum
  end

  def chore_xp
    @user_chore_exp = Chore.where(chore_completer_id: current_user.id, completed: true).pluck(:chore_xp).sum
  end

  def item_xp
    @user_item_exp = Item.where(purchaser_id: current_user.id, purchased: true).pluck(:item_xp).sum
  end

  def calc_total
    chore_xp
    item_xp
    @total_xp = @user_chore_exp + @user_item_exp
    @user_exp = @total_xp
  end

  def calc_exp(input)
    exp = 200.0
    @level = 1
    until exp >= input.to_f
      @level += 1
      exp = exp * 2.0
    end
    @percent = (input.to_f/exp)*100
    if @percent == 100
      @percent = 0
    end
  end

  def user_params
    params.require(:user).permit(:email, :avatar, :venmo_username, :created_at, :paypal)
  end

end
