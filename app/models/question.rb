class Question < ApplicationRecord

  belongs_to :user
  has_many :answers, dependent: :destroy

  # has_one_attached :file
  has_many_attached :files

  validates :title, :body, presence: true
end
