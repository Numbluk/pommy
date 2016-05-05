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

  def total_labor_time
    get_stages_by('labor').count * 30
  end

  def total_rest_time
     get_stages_by('short_rest').count * 5 + total_clear() * 15
  end

  def total_stages_complete
    self.stages.count
  end

  def total_clear
    get_stages_by('long_rest').count
  end

  def get_stages_by(stage_type)
    self.stages.where(stage_type: stage_type)
  end
end
