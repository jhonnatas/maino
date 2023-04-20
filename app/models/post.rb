class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :by_recently_created, -> { order(created_at: :desc) }

  paginates_per 3

  validates :title, presence: true, length: { minimum: 10, maximum: 200 }
  validates :description, presence: true, length: { minimum: 10, maximum: 4000 }
end
