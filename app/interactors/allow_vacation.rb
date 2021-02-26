class AllowVacation
  include Interactor

  def call  
    user = context.user
    vacant_hours = context.days * 8
    start_date = context.start
    finish = day_of_finish(start_date, context.days)
    
    return context.fail!(message: "Not enough days") unless allowed_vacation?(user, context.days)

    take_vacation(user, context.days) 

    return context.fail!(message: "No free slot") unless has_free_slot?(vacant_hours, user)
    
    AllocatedTimeSlot.create(
      date_start: start_date,
      date_end: finish,
      status: 'vacation',
      time_in_hours: vacant_hours,
      user: user
    )     
  end

  private

  def has_free_slot?(vacant_hours, user)    
    vacant_hours + user.regular_month_hours_count <= AllocatedTimeSlot::MONTHLY_HOURS
  end

  def day_of_finish(start_date, vac_days)
    n = 0
    cur_date = start_date
    yearly_holidays = Holiday.current_year.pluck(:date)

    while n < vac_days   
      n += 1 unless cur_date.saturday? || cur_date.sunday? || cur_date.in?(yearly_holidays) 
      cur_date += 1.day 
    end

    cur_date
  end

  def max_vacation_days(user)
    user.vacations.where(status: 'active').pluck(:quantity).sum
  end

  def allowed_vacation?(user, vac_days)
    vac_days <= max_vacation_days(user)
  end

  def take_vacation(user, vac_days) 

    user.vacations.where(status: 'active').each do |vacation| 
      break if vac_days.zero?   
      break vacation.update(quantity: vacation.quantity - vac_days) if vac_days <  vacation.quantity

      vac_days = vac_days - vacation.quantity      
      vacation.update(status: 'used')        
    end
  end
end
