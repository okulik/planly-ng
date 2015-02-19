class Trip < ActiveRecord::Base
  belongs_to :user
  
  validates :destination, presence: true, length: { maximum: 255 }
  validates :start_date, :end_date, presence: true, length: { is: 10 }
  validates :user_id, presence: true
  validate :end_date_cannot_be_before_start_date

  attr_accessor :days

  def end_date_cannot_be_before_start_date
    if start_date && end_date && end_date < start_date
      errors.add(:end_date, "can't be smaller than the start date")
    end
  end

  def days
    return (start_date - Date.today).to_i
  end

  def as_json(options={})
    super(only: [:tid, :destination, :start_date, :end_date, :comment], methods: :days)
  end
end