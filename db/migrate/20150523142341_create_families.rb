class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.references :creator
      t.references :event, index: true

      t.timestamps
    end
  end
end
