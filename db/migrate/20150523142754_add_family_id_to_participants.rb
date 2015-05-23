class AddFamilyIdToParticipants < ActiveRecord::Migration
  def change
    add_reference :participants, :family, index: true
  end
end
