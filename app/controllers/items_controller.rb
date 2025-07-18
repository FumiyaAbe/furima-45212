class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :move_to_index_if_sold_out, only: [:edit, :update, :destroy]

  # 後ほど実装する(一覧)
  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
    # 次と前の商品表示の為の記述はじまり
    @previous_item = Item.where('id < ?', @item.id).order(id: :desc).first
    @next_item = Item.where('id > ?', @item.id).order(id: :asc).first
    @previous_item = Item.where('id < ?', @item.id).order(id: :desc).first
    @next_item = Item.where('id > ?', @item.id).order(id: :asc).first
    # 次と前の商品表示の為の記述終わり
  end

  def edit
    redirect_to root_path unless current_user == @item.user
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless @item.user_id == current_user.id
  end

  # ここで購入済み商品を編集できないように制御
  def move_to_index_if_sold_out
    redirect_to root_path if @item.sold_out?
  end

  def item_params
    params.require(:item).permit(:name, :info, :price, :image, :category_id, :sales_status_id, :shipping_fee_status_id,
                                 :prefecture_id, :scheduled_delivery_id)
          .merge(user_id: current_user.id)
  end
end
