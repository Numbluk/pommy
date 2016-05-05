class User < ActiveRecord::Base
  has_many :stages

  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3 },
                       format: { with: /\A[0-9a-zA-Z]+\z/, message: "can only contain letters and numbers." }

  validates :password, on: :create,
                       presence: true,
                       length: { minimum: 3 },
                       format: { with: /\A[0-9a-zA-Z]+\z/, message: "can only contain letters and numbers." }

  has_secure_password
end
