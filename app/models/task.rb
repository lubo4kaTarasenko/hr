class Task
  include Mongoid::Document

  field :description, type: String
  field :git_url, type: String
  field :status, type: String
  field :started_at, type: Date
  field :resorved_at, type: Date
  field :points, type: Integer

  belongs_to :user
  belongs_to :project
  
  validates_inclusion_of :points, in: (1..8)
end
