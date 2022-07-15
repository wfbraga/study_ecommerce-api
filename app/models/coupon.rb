# frozen_string_literal: true

class Coupon < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :status, presence: true
  validates :discount_value, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :due_date, presence: true, future_date: true

  enum status: { inactive: 0, active: 1 }
end
