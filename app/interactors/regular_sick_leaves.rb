class RegularSickLeaves
  include Interactor

  def call
    take_away_sick_leaves
    add_sick_leaves
  end

  private

  def add_sick_leaves
    users = User.all
    users.each do |user|
      user.sick_leaves.create
    end
  end

  def take_away_sick_leaves
    old_sick_leaves = SickLeave.active
    old_sick_leaves.update_all(status: 'burnt')
  end
end
