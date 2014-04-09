class CreatePurchasess < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :purchaser, index: true
      t.references :item, index: true
      t.references :file_import, index: true
      t.references :merchant, index: true
      t.integer    :count

      t.timestamps
    end
  end
end
