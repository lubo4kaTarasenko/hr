class HolidayMonthlyWorker
  include Sidekiq::Worker

  def perform
    BookMonthlyHolidays.call
  end
end   
