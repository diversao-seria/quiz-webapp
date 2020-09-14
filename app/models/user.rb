class User < ApplicationRecord
    has_many :quizzes
    has_secure_password

end
