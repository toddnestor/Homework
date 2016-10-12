class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, :url, :user, presence: true
end
