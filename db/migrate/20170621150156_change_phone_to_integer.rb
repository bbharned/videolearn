class ChangePhoneToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :attendees, :phone, :string
  end
end
