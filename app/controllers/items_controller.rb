class ItemsController < ApplicationController
  before_action :set_item, except: [:create, :index]

  def index
    @home = Home.find_by(params[:id])
    @items = @home.list.items.where(purchased: false)
  end


  def show
    @item
  end


  def create
    @item = Item.new(item_params)
    @item.item_creator = current_user.id
    if @item.save
      render :show, status: 201
    else
      render :error
    end
  end


  def update
    if @item.update(item_params)
      render :show
    else
      render :error
    end
  end


  def purchase
    @item.purchaser_id = current_user.id
    @item.purchased = true
    @item.purchased_at = Time.now
    if @item.save
      render :action_successful, status: 200
    else
      render :error
    end
  end


  def purchased_items
    @home = Home.find_by(params[:id])
    @items = @home.list.items.where(purchased: true)
  end


  def destroy
    authorize @item
    @item.destroy
  end





  private

  def set_item
    begin
      @item = Item.find_by(id: params[:id], home_id: params[:home_id])
    rescue
      render 'not_found'
    end
  end


  def item_params
    params.require(:item).permit(:home_id, :title, :item_xp)
  end


end