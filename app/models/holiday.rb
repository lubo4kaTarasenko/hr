class Holiday
  include Mongoid::Document

  field :date, type: Date
  field :summary, type: String

  scope :current_month, -> { where(date: (Time.now.beginning_of_month..Time.now.end_of_month)) }
  scope :current_year, -> { where(date: (Time.now.beginning_of_year..Time.now.end_of_year)) }
end
