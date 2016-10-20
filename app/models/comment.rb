class Comment < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :user
  belongs_to :topic
  has_many :notifications, dependent: :destroy
end
