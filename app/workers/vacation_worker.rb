class VacationWorker
  include Sidekiq::Worker

  def perform
    TakeAwayVacation.call
    GiveVacation.call
  end
end   
