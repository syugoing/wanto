class Defochange < ActiveRecord::Migration
  def change
    change_column_null :users, :uid, false
    change_column_null :users, :provider, false
    change_column_default :users, :uid, ""
    change_column_default :users, :provider, ""

    add_index :users, [:uid, :provider], unique: true
  end
end
