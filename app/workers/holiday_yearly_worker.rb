class HolidayYearlyWorker
  include Sidekiq::Worker

  def perform
    GoogleCalendarInteractors::YearlyHolidays.call
  end
end   
