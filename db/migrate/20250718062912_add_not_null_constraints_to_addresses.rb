class AddNotNullConstraintsToAddresses < ActiveRecord::Migration[7.1]
  def change
    change_column_null :addresses, :postal_code, false
    change_column_null :addresses, :prefecture_id, false
    change_column_null :addresses, :city, false
    change_column_null :addresses, :address, false
    change_column_null :addresses, :phone_number, false
  end
end
