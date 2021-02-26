class TakeAwayVacation
  include Interactor

  def call
    old_month = Date.today - 2.months
    old_month_range = (old_month.beginning_of_month..old_month.end_of_month)
    old_regular_vacations = Vacation.where(kind: 'regular', status: 'active', date: old_month_range)
    old_regular_vacations.update_all(status: 'burnt')   
  end 
end
