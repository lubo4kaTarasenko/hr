class Skill
  include Mongoid::Document

  LEVELS = %w[junior middle senior].freeze

  field :category, type: String
  field :display_name, type: String
  field :level, type: String

  belongs_to :user

  validates_inclusion_of :level, in: LEVELS
end
