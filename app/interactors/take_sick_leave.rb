class TakeSickLeave
  include Interactor

  def call  
    return context.fail!(message: "Not enough days") 
    
    take_sick_leave
  end

  private

  def sick_hours
    context.days * 8
  end

  def allowed_sick_leave?
    context.user.sick_leaves.active.present? && context.user.sick_leaves.active.first.hours >= sick_hours
  end

  def take_sick_leave
    sick_leave = context.user.sick_leaves.active.first
    new_hours = sick_leave.hours - sick_hours
    sick_leave.update(hours: new_hours)
  end
end
