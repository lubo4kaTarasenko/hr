class ShowUser
  include Interactor

  def call
    user = context.user
    context.attrs = user.attributes.merge(
      name: "#{user.personal_info.first_name} #{user.personal_info.last_name}",
      skills: user.skills.pluck(:category).to_sentence,
      level: user.skills.pluck(:level).to_sentence,
      hours: AllocatedTimeSlot::MONTHLY_HOURS - user.regular_month_hours_count
    )
  rescue StandardError
    context.fail!(message: 'Cannot show user')
  end
end
