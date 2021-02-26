module Types
  class AllocatedTimeSlotType < Types::BaseObject
    field :date_start, String, null: true
    field :date_end, String, null: true
    field :time_in_hours, String, null: true
    field :status, String, null: true
    field :user, UserType, null: false
  end
end
