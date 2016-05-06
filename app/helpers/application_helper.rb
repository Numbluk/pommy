module ApplicationHelper
  def labor_time_prettyfied(time)
    if time == 0
      'Not Yet Begun'
    else
      (time.to_f / 60).round(2).to_s + ' Hrs.'
    end
  end
end
