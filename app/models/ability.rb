# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :book, User if user&.has_role? :manager    
  end
end
