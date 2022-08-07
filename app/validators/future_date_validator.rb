# frozen_string_literal: true

# Remember: all model validators must inherit from ActiveModel::EachValidator
class FutureDateValidator < ActiveModel::EachValidator
  # Also, is necessary implement a method with name validate_each
  def validate_each(record, attribute, value)
    return unless value.present? && value <= Time.zone.now

    message = options[:message] || :future_date # future_date error message is implemente on lacales

    record.errors.add(attribute, message)
  end
end
