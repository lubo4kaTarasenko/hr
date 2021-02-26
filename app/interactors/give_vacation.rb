class GiveVacation
  include Interactor

  def call
    users = User.all
    users.each do |user|
      user.vacations.create
    end
  end
end
