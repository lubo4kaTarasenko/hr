class EquipmentMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def request_email(user, devops, message)
    @user = user
    @devops = devops
    @message = message
    mail(to: @devops, subject: 'Request equipment')
  end
end
