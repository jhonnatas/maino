# == Schema Information
#
# Table name: taggables
#
#  id         :bigint           not null, primary key
#  post_id    :bigint           not null
#  tag_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Taggable < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end
