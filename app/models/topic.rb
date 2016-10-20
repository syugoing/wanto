class Topic < ActiveRecord::Base
  validates :content, presence: true
  mount_uploader :picture, AvatarUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
end
