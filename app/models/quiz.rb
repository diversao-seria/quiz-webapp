class Quiz < ApplicationRecord
    belongs_to :user
    has_many :matches

    validates :user, :title, :questions, presence: true
    validates :title, length: { maximum: 32 }

end
