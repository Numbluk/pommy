module ApplicationHelper
  def labor_time_prettyfied
    if @user.total_labor_time == 0
      'Not Yet Begun'
    else
      (@user.total_labor_time.to_f / 60).to_s + ' Hrs.'
    end
  end
end
