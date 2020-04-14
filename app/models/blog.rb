class Blog < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :title, presence: true

  # mount_uploader :photo, ImageUploader
  mount_uploader :image, BlogImageUploader
end
