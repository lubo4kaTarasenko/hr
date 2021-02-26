class SendEmail
  include Interactor

  def call
    message = context.message
    user = context.user
    EquipmentMailer.request_email(
      user.email,
      user_devops(user).email, 
      message
    ).deliver_later
  rescue StandardError
    context.fail!(message: 'Something went wrong')
  end

  private 

  def user_devops(user)
    ops_role = Role.find_by(name: 'devops')
    project = user.projects.to_a.select { |p| p.users.find_by(role_ids: ops_role.id) }.first
    return any_devops(ops_role) unless project
    
    project.users.find_by(role_ids: ops_role.id)
  end

  def any_devops(ops_role)
    User.find_by(role_ids: ops_role.id) 
  end
end
