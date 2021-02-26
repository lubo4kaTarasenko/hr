module Types
  class UserType < Types::BaseObject
    field :email, String, null: true
    field :english_level, String, null: true
    field :name, String, null: true
    field :skills, String, null: true
    field :level, String, null: true
    field :vacations, String, null: true
    field :sick_leaves, String, null: true
    field :booked_slots, String, null: true
    field :hours, String, null: true
    field :time_slots, String, null: true
    field :allocated_time_slots, [Types::AllocatedTimeSlotType], null: true
  end
end
