class Asset
  include Mongoid::Document

  field :count, type: Integer
  field :name, type: String
  field :specs, type: String

  belongs_to :user
end
