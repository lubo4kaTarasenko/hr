class UploadUsersCsv
  include Interactor

  def call
    session = GoogleDrive::Session.from_config("config/google_creds.json")
    google_file = session.upload_from_file(context.path, "users.csv", convert: false)

    google_file.acl.push(type: "anyone", role: "reader")    
    context.link = google_file.web_view_link
  rescue StandardError
    context.fail!(message: 'Something went wrong. File was not uploaded')
  end
end
