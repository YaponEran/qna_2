class Question < ApplicationRecord

  include Votable

  belongs_to :user
  has_many :answers, dependent: :destroy

  has_one :award, dependent: :destroy
  accepts_nested_attributes_for :award, reject_if: :all_blank

  has_many :links, dependent: :destroy, as: :linkable
  accepts_nested_attributes_for :links, reject_if: :all_blank 

  # has_one_attached :file
  has_many_attached :files

  validates :title, :body, presence: true

  def set_award!(user)
    award&.update!(user: user)
  end
end
