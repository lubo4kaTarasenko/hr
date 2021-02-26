class PersonalInfo
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  #field :agreement_date, type: String, encrypted: true

  belongs_to :user
end
