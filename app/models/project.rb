class Project
  include Mongoid::Document

  field :name, type: String
  field :status, type: String
  field :status, type: String
  field :feedback_sent, type: Boolean,  default: false

  has_and_belongs_to_many :users
  has_many :comments
  has_many :tasks
end
