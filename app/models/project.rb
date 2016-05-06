class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :users, through: :stages

  validates :project_name, presence: true,
                           uniqueness: true,
                           length: { minimum: 3 },
                           format: { with: /\A[0-9a-zA-Z\ \-]+\z/, message: "Invalid project name" }
end
