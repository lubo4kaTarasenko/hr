class ShowAllUserInfo
  include Interactor

  def call
    context.users = context.user_collection.map do |user|
      user.attributes.merge(
        name: "#{user.personal_info.first_name} #{user.personal_info.last_name}",
        skills: user.skills.pluck(:category).to_sentence,
        level: user.skills.pluck(:level).to_sentence,
        hours: AllocatedTimeSlot::MONTHLY_HOURS - user.regular_month_hours_count,
        vacations: user.vacations.active.pluck(:days).sum,
        sick_leaves: user.sick_leaves.active.pluck(:hours).sum.to_f / 8,
        time_slots: show_time_slots(user)
      )
      end
  rescue StandardError
    context.fail!(message: 'Cannot show users')
  end

  private

  def show_time_slots(user)
    user.allocated_time_slots.includes(:project).on_this_month.map do |slot|
      attrs = {
        date_start: slot[:date_start].to_date,
        date_end: slot[:date_end].to_date,
        hours: slot[:time_in_hours],
        type: slot[:status],
        project: slot.project&.name
      }
      attrs.map { |k, v| [k, v].join(' - ') }.join(', ')
    end
  end
end
