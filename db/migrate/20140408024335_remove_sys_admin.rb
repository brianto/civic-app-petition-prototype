class RemoveSysAdmin < ActiveRecord::Migration
  def change
    drop_table :sysadmins
  end
end
