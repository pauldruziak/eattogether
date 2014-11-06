class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description
      t.integer :amount
      t.references :event, index: true
      t.references :creator, index: true

      t.timestamps
    end
  end
end
