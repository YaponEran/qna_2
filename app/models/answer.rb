class Answer < ApplicationRecord
  
  belongs_to :question
  belongs_to :user

  has_many_attached :files

  has_many :links, dependent: :destroy, as: :linkable
  accepts_nested_attributes_for :links, reject_if: :all_blank 

  default_scope { order(best: :desc) }
  
  validates :body, presence: true
  validates :best, uniqueness: { scope: :question }, if: :best?

  def  update_to_best!
    best_answer = question.answers.find_by(best: true)

    Answer.transaction do
      best_answer&.update(best: false)
      update(best: true)
      question.set_award!(user)
    end
  end
end
