class GoogleCalendarInteractors::SaveHolidays
  include Interactor
  
  def call 
    context.response.items.each do |event|
      Holiday.create(date: event.start.date, summary: event.summary)
    end
  end
end
