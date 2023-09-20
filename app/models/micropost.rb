class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  # default_scope -> {order created_at: :desc}
  scope :recent_posts, ->{order created_at: :desc}
  cope :relate_post, ->(user_ids){where user_id: user_ids}
  validates :content, presence: true, length: {maximum: Settings.digit_140}
  validates :image,
            content_type: {in: Settings.image_type,
                           message: :image_format},
            size: {less_than: 5.megabytes,
                   message: :image_load}
  delegate :name, to: :user

  def display_image
    image.variant resize_to_limit: [500, 500]
  end
end
