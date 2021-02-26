class Vacation
  include Mongoid::Document

  STATUSES = %w[active used burnt].freeze
  KINDS = %w[regular additional].freeze

  field :quantity, type: Integer, default: 2
  field :date, type: Date, default: Date.today
  field :kind, type: String, default: 'regular'
  field :status, type: String, default: 'active'

  belongs_to :user

  validates_inclusion_of :kind, in: KINDS
  validates_inclusion_of :status, in: STATUSES 
  
  scope :active, -> { where(status: 'active') }
end
