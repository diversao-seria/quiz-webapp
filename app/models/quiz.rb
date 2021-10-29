class Quiz < ApplicationRecord
  belongs_to :user
  has_many :matches
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :user, :title, :questions, presence: true
  validates :title, length: { maximum: 32 }

  before_create :generate_code

  private
  
  def generate_code
    self.code = SecureRandom.alphanumeric(4).tr('0-9','a-z').upcase
    generate_code if Quiz.exists?(code: self.code)
  end
end
