class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit] # ← :update, :destroy を編集・消去機能実装時に追加
  # before_action :set_item, only: [:show, :edit, :update] #←詳細・編集機能実装時に追加

  # 後ほど実装する(一覧)
  # def index
  #   @items = Item.includes(:user).order(created_at: :desc)
  # end

  def new
    @item = Item.new
  end

  # 後ほど実装する(詳細)
  # def show
  #   @item = Item.find(params[:id])
  # end

  # 後ほど実装する(編集)
  # def edit
  #   # 出品者以外はトップページへリダイレクト
  #   redirect_to root_path unless current_user == @item.user
  # end

  # 後ほど実装する(編集)
  # def update
  #   if @item.update(item_params)
  #     redirect_to item_path(@item)
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # #下記をコメントアウトするとエラーが出る(Unknown action )
  # def destroy
  #   @item = Item.find(params[:id])
  #   if @item.user_id == current_user.id
  #     @item.destroy
  #     redirect_to root_path, notice: '商品を削除しました'
  #   else
  #     redirect_to root_path, alert: '不正な操作です'
  #   end
  # end

  # private

  # def set_item
  #   @item = Item.find(params[:id])
  # end

  # app/controllers/items_controller.rb

  def item_params
    params.require(:item).permit(:name, :info, :price, :image, :category_id, :sales_status_id, :shipping_fee_status_id,
                                 :prefecture_id, :scheduled_delivery_id)
          .merge(user_id: current_user.id)
  end
end
