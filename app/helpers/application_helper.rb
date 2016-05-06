module ApplicationHelper
  def labor_time_prettyfied(time)
    if time == 0
      'Not Yet Begun'
    else
      (time.to_f / 60).round(2).to_s + ' Hrs.'
    end
  end

  def labor_as_percentage(contribution, total)
    return 'N/A' if total == 0
    ((contribution.to_f / total) * 100).to_i.to_s + ' %'
  end

  def addable_user(project_id, user)
    project = Project.find(project_id)
    users = []
    Invitation.where(project_id: project_id).each { |invite| users << invite.user }

    inviteable_users = (User.all - users)

    if project.owner.username != user.username &&
       !project.users.include?(user) &&
       inviteable_users.include?(user)
       return true
    end
    false
  end
end
