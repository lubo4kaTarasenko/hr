class CreateSickSlot
  include Interactor

  def call
    return context.fail!(message: "No free slot") unless has_free_slot?
    AllocatedTimeSlot.create(
      date_start: context.start,
      date_end: day_of_finish,
      status: 'sick',
      time_in_hours: sick_hours,
      user: context.user
    )    
  end

  private

  def has_free_slot?   
    context.days * 8 + context.user.regular_month_hours_count <= AllocatedTimeSlot::MONTHLY_HOURS
  end

  def day_of_finish
    n = 0
    cur_date = context.start
    yearly_holidays = Holiday.current_year.pluck(:date)

    while n < context.days   
      n += 1 unless cur_date.saturday? || cur_date.sunday? || cur_date.in?(yearly_holidays) 
      cur_date += 1.day 
    end

    cur_date
  end  
end
