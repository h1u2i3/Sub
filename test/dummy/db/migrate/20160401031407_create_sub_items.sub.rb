# This migration comes from sub (originally 20160330063759)
class CreateSubItems < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_items do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
