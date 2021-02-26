class SickLeaveWorker
  include Sidekiq::Worker

  def perform
    RegularSickLeaves.call
  end
end   
