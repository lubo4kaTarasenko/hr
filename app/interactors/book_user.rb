class BookUser
  include Interactor

  def call
    params = context.params
    status = params[:status] == '1' ? 'overtime' : 'regular'
    project = Project.find_by(name: params[:project])
    slot = AllocatedTimeSlot.create(
      user_id: params[:user],
      date_start: params[:start],
      date_end: params[:finish],
      status: status,
      time_in_hours: params[:time],
      project: project
    )
    User.find(params[:user]).projects << project

    context.fail!(message: "Booking fields are invalid") unless slot.valid?
  end
end
