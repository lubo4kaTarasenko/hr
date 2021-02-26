class Report
  include Mongoid::Document

  field :daily_charges, type: Float
  field :date, type: Date, default: Date.today
  field :taxes_compansation, type: Float, default: 1.3
  field :account_service_compensation, type: Float, default: 0.8
  field :rent_compansation, type: Float, default: 0.4
  field :invoice_total, type: Float
  field :additionals, type: Array

  belongs_to :user
end
