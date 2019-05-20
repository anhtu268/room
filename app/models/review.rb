class Review < ApplicationRecord
  include ReviewDecorator

  belongs_to :user
  belongs_to :location

  after_create :rate_calculate

  REVIEW_PARAMS = [:comment, :rate, :location_id].freeze

  private
  def rate_calculate
    average_rate = self.location.reviews.average(:rate)
    self.location.update_columns(total_rate: average_rate)
  end
end
