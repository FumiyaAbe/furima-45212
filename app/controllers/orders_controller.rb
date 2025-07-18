class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root, only: [:index, :create]
  before_action :set_payjp_public_key

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      puts @order_address.errors.full_messages
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    return unless current_user == @item.user || @item.sold_out?

    redirect_to root_path
  end

  def set_payjp_public_key
    gon.public_key = Rails.application.credentials[:payjp_public_key]
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    puts '決済開始'
    Payjp.api_key = Rails.application.credentials[:payjp_secret_key]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
    puts '決済完了'
  end
end
