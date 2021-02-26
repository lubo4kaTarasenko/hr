class ShowUserReport
  include Interactor

  def call
    report = context.user.reports.find_by(date: context.date).attributes

    context.report = report
  rescue StandardError
    context.fail!(message: 'Cannot show report')
  end  
end
