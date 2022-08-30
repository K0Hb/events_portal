class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true

  has_many_attached :images

  # scope :persisted, -> { where "id IS NOT NULL" }
end
