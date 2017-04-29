class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.string :product
      t.references :, foreign_key: true
      t.string :cart
      t.belong_to :

      t.timestamps
    end
  end
end
