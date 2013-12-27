class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :default_name
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
