class Comment
  include Mongoid::Document

  field :body, type: String

  belongs_to :project
end
