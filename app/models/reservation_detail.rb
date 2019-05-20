class ReservationDetail < ApplicationRecord
  DATE_TIME_REGEX = /\d{4}\-\d{2}\-\d{2}/

  belongs_to :reservation
  belongs_to :room

  validates :start_date, presence: true, format: {with: DATE_TIME_REGEX}
  validates :end_date, presence: true, format: {with: DATE_TIME_REGEX}
  validate :valid_start_date
  validate :valid_end_date
  validate :valid_days
  validate :valid_room_ready

  def valid_start_date
    errors.add(:start_date, "is not valid") unless self.start_date >= Time.now
  end

  def valid_end_date
    errors.add(:start_date, "is not valid") unless self.end_date >= Time.now
  end

  def valid_days
    errors.add(:end_date, "days must more than one") if self.end_date == self.start_date
  end

  def valid_room_ready
    room = Room.find_by id: self.room_id
    errors.add(:end_date, "room is full") unless size_between_time(self.start_date, self.end_date) < room.quantity
  end

  private
  def size_between_time(start_date, end_date)
    room = Room.find_by id: self.room_id
    room.reservation_details.where("start_date >= ? AND end_date <= ?",start_date,end_date).size
  end
end
