class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :stages
  has_many :users, through: :stages
  has_many :invitations

  validates :project_name, presence: true,
                           uniqueness: true,
                           length: { minimum: 3 },
                           format: { with: /\A[0-9a-zA-Z\ \-]+\z/, message: "Invalid project name" }


  def total_labor_time
    get_stages_by('labor').count * 30
  end

  def total_clear
   get_stages_by('long_rest').count
  end

  def get_stages_by(stage_type)
   self.stages.where(stage_type: stage_type)
  end
end
