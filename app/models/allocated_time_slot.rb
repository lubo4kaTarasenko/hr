class AllocatedTimeSlot
  include Mongoid::Document 

  STATUSES = %w[regular overtime vacation sick holiday].freeze
  MONTHLY_HOURS = 160

  field :date_start, type: Date
  field :date_end, type: Date
  field :time_in_hours, type: Integer
  field :status, type: String, default: 'regular'

  belongs_to :user
  belongs_to :project

  validates_inclusion_of :status, in: STATUSES
  validate :on_this_month
  validate :in_month_limit  

  scope :on_this_month, -> { where(date_start: (Time.now.beginning_of_month..Time.now.end_of_month)) }    

  private

  def on_this_month
    errors.add(:date_end, 'is out of this month') unless date_end.try(:month).eql?(Time.now.month) 
    errors.add(:date_start, 'is out of this month') unless date_start.try(:month).eql?(Time.now.month) 
  end

  def in_month_limit
    errors.add(:time_in_hours, 'month limit exceeded') unless limited?
  end

  def limited?
    return true if status.eql?('overtime')

    (time_in_hours.to_i + user.regular_month_hours_count) <= MONTHLY_HOURS 
  end  
end
