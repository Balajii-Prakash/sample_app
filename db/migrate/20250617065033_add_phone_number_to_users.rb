class AddPhoneNumberToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :phone_number, :integer
  end
end
