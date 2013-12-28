class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :default_name, presence: true

  def display_name
    default_name
  end
end
