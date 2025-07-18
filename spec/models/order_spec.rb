require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Orderのバリデーション' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
    end

    it 'user_idとitem_idがあれば保存できる' do
      order = Order.new(user_id: @user.id, item_id: @item.id)
      expect(order).to be_valid
    end

    it 'user_idが空では保存できない' do
      order = Order.new(user_id: nil, item_id: @item.id)
      order.valid?
      expect(order.errors.full_messages).to include('User must exist')
    end

    it 'item_idが空では保存できない' do
      order = Order.new(user_id: @user.id, item_id: nil)
      order.valid?
      expect(order.errors.full_messages).to include('Item must exist')
    end
  end
end
