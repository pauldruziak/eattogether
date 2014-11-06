class CreatePayers < ActiveRecord::Migration
  def change
    create_table :payers do |t|
      t.references :transaction, index: true
      t.references :participant, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
