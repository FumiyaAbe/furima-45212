class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association
  has_many :items
  # has_many :orders

  # ニックネーム必須
  validates :nickname, presence: true

  # 名前（全角：漢字・ひらがな・カタカナ）
  # 名前（全角：漢字・ひらがな・カタカナ、「ー」「ヶ」なども許容）
  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ヶー一-龥々]+\z/, message: 'は全角で入力してください' }

  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶー一-龥々]+\z/, message: 'は全角で入力してください' }

  # カナ（全角カタカナのみ ※「ー」「－」「ヶ」含む）
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }

  # 生年月日 必須
  validates :birth_date, presence: true

  # パスワードのバリデーション（半角英数字混合）
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }
end
