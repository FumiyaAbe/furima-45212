require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it 'すべての項目が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end

      it '価格が300円以上であれば保存できる' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it '価格が9,999,999円以下であれば保存できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end

      it '価格が半角数字なら保存できる' do
        @item.price = 1000
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '説明が空では保存できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it 'カテゴリーが---（id:1）では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end

      it '商品の状態が---（id:1）では保存できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status を選択してください')
      end

      it '配送料の負担が---（id:1）では保存できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee status を選択してください')
      end

      it '発送元の地域が---（id:1）では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択してください')
      end

      it '発送までの日数が---（id:1）では保存できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery を選択してください')
      end

      it '価格が空では保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が299円以下では保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字かつ¥300〜¥9,999,999の間で入力してください')
      end

      it '価格が10,000,000円以上では保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字かつ¥300〜¥9,999,999の間で入力してください')
      end

      it '価格が全角数字では保存できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字かつ¥300〜¥9,999,999の間で入力してください')
      end

      it '価格が文字列では保存できない' do
        @item.price = 'three hundred'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字かつ¥300〜¥9,999,999の間で入力してください')
      end

      it '価格が英数字混合では保存できない' do
        @item.price = '300yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字かつ¥300〜¥9,999,999の間で入力してください')
      end

      it 'userが紐付いていなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
