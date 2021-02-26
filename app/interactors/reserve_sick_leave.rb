class ReserveSickLeave
  include Interactor::Organizer

  organize TakeSickLeave, CreateSickSlot
end
