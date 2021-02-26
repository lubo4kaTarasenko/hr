class ReportsWorker
  include Sidekiq::Worker

  def perform
    GenerateReports.call
  end
end   
