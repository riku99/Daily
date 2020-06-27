class List < ApplicationRecord
  validates :title, presence: true
  validates :priority, presence: true
end
