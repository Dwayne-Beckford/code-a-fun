class UserLevel < ApplicationRecord
  belongs_to :user
  belongs_to :level

  scope :completed, -> { where(completed: true ) }
end
