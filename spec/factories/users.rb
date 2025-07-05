FactoryBot.define do
  factory :user do
    nickname              { 'test_user' }
    email                 { Faker::Internet.email }
    password              { 'a1b2c3d4' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birth_date            { '2000-01-01' }
  end
end
