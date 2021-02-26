class BookMonthlyHolidays
  include Interactor

  def call
    montly_holidays_dates = Holiday.current_month.pluck(:date)
    users = User.all 

    montly_holidays_dates.each do |date|
      users.each do |user|
        AllocatedTimeSlot.create(
          user: user,
          date_start: date,
          date_end: date,
          status: 'holiday',
          time_in_hours: 8
        )    
      end
    end
  end
end
