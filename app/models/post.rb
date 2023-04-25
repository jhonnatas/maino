# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables

  has_one_attached :image
  
  scope :by_recently_created, -> { order(created_at: :desc) }

  paginates_per 3

  validates :title, presence: true, length: { minimum: 2, maximum: 200 }
  validates :description, presence: true, length: { minimum: 2, maximum: 4000 }
end
