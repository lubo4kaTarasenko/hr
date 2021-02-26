class User
  include Mongoid::Document
  include Mongoid::Paperclip

  ENGLISH_LEVELS = %w[none beginner pre-intermediate intermediate upper-intermediate advanced].freeze

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %w[google_oauth2]

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String  
  field :salary, type: Integer
  field :english_level, type: String, default: 'none'
  field :status, type: String
  field :token, type: String
  field :additionals, type: Array
  has_mongoid_attached_file :resume  
  has_mongoid_attached_file :photo

  has_one :personal_info
  has_and_belongs_to_many :projects
  has_many :assets
  has_many :tasks
  has_many :skills
  has_many :vacations
  has_many :sick_leaves  
  has_many :allocated_time_slots
  has_many :reports
  
  validates_inclusion_of :english_level, in: ENGLISH_LEVELS
  validate :correct_additionals

  before_create :add_default_role
  before_create :generate_token

  scope :full_info, -> { 
    order(id: :desc).includes(
      :personal_info,
      :skills, 
      :vacations, 
      :sick_leaves,
      :allocated_time_slots
  )}

  def regular_month_hours_count
    time_range = (Time.now.beginning_of_month..Time.now.end_of_month)
    statuses = %w[regular vacation sick]
    allocated_time_slots.where(date_start: time_range).in(status: statuses).map(&:time_in_hours).sum
  end

  def active_sick_leave
    sick_leaves.active.first
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    User.find_by(email: data['email'])
  end

  private

  def add_default_role
    add_role :master
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def correct_additionals
    return unless additionals
    additionals.each do |additional|      
      return errors.add(:additionals, 'additionals invalid') unless additional_valid?(additional)
    end
  end

  def additional_valid?(additional)
    %i[date name amount].all? { |key| additional[key] }
  end
end
