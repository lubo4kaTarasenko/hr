require 'csv'

class CreateUsersCsv
  include Interactor

  def call
    context.path = Rails.root.join('tmp/users.csv').to_s
    users_datas = context.users.map do |user|
      user.slice(*context.params)
    end

    CSV.open(context.path, 'wb') do |csv|
      csv << context.params
      users_datas.each do |data|
        values = context.params.map { |key| data[key] }
        csv << values
      end
    end  
  end
end
