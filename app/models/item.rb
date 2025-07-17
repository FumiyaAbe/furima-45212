class Item < ApplicationRecord
  # ActiveStorageで画像を添付
  has_one_attached :image

  # アソシエーション
  belongs_to :user
  has_one :order

  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # 購入済みかどうかの判断
  def sold_out?
    order.present?
  end

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
  end

  # ActiveHashにおける「---（id: 1）」を選択させない
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  # 価格の範囲指定バリデーション
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: 'は半角数字かつ¥300〜¥9,999,999の間で入力してください'
            }
end
