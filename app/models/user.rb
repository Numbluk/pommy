class User < ActiveRecord::Base
  has_many :stages
  has_many :owned_projects, foreign_key: 'user_id', class_name: 'Project'
  has_many :projects, through: :stages
  has_many :invitations

  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3 },
                       format: { with: /\A[0-9a-zA-Z]+\z/, message: "can only contain letters and numbers." }

  validates :password, on: :create,
                       presence: true,
                       length: { minimum: 3 },
                       format: { with: /\A[0-9a-zA-Z]+\z/, message: "can only contain letters and numbers." }

  has_secure_password

  def total_labor_time
    get_stages_by('labor').count * 30
  end

  def total_rest_time
     get_stages_by('short_rest').count * 5 + total_clear() * 15
  end

  def total_clear
    get_stages_by('long_rest').count
  end

  def get_stages_by(stage_type)
    self.stages.where(stage_type: stage_type)
  end

  def total_by_project_and_stage(project_id, stage)
    count = self.stages.where(project_id: project_id).where(stage_type: stage).count

    case stage
    when 'labor'
      return count * 30
    when 'short_rest'
      return count * 5
    when 'long_rest'
      return count * 15
    end
  end

  def has_misc_stages?
    self.stages.where(project_id: nil)
  end
end
