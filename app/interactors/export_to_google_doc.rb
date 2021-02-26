class ExportToGoogleDoc
  include Interactor::Organizer

  organize ShowAllUserInfo, CreateUsersCsv, UploadUsersCsv
end
