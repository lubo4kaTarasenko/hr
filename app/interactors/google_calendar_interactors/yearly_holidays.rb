class  GoogleCalendarInteractors::YearlyHolidays
  include Interactor::Organizer

  organize GoogleCalendarInteractors::ExtractHolidays, GoogleCalendarInteractors::SaveHolidays
end
