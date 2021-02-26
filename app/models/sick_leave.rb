class SickLeave
  include Mongoid::Document

  STATUSES = %w[active used burnt].freeze

  field :hours, type: Integer, default: 24
  field :date, type: Date, default: Date.today
  field :status, type: String, default: 'active'

  belongs_to :user

  validates_inclusion_of :status, in: STATUSES  

  scope :active, -> { where(status: 'active') }  
end
