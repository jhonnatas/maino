class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 10, maximum: 80 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
