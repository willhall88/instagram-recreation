class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders
  has_and_belongs_to_many :tags

  validates :user_id, presence: true

  has_attached_file :picture, :styles => { :medium => "450x600>", :thumb => "100x100>" },
  storage: :s3,
  s3_credentials: {
    bucket: 'Willstagram',
    access_key_id: Rails.application.secrets.s3_access_key,
    secret_access_key: Rails.application.secrets.s3_secret_key
  }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  def comment
  end

  def create_comment(comment_text)
    new_comment = self.comments.create(comment: comment_text, user: self.user)
    new_comment.create_hashtags
  end


end
