class List < ApplicationRecord
  validates :title, presence: true
  validates :priority, presence: true

  default_scope -> { order(created_at: :desc) }
end
