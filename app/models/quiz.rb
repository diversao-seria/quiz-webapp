class Quiz < ApplicationRecord
  belongs_to :user
  has_many :matches
  has_many :questions
  accepts_nested_attributes_for :questions

  validates :user, :title, :questions, presence: true
  validates :title, length: { maximum: 32 }

  before_create :generate_code

  protected
    def generate_code
      self.code = SecureRandom.alphanumeric(4).tr('0-9','a-z').upcase
      generate_code if Quiz.exists?(code: self.code)
    end
end
