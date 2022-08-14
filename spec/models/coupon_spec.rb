require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to define_enum_for(:status).with_values({ inactive: 0, active: 1 }) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to validate_presence_of(:discount_value) }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }

  # custon tests using the custon validator furute_date
  it 'can not have past date as due_date' do
    subject.due_date = 1.day.ago
    subject.valid?
    expect(subject.errors.keys).to include :due_date
  end

  it 'can not have current date as due_date' do
    subject.due_date = Time.zone.now
    subject.valid?
    expect(subject.errors.keys).to include :due_date
  end

  it 'is valid if due_date has a future date' do
    subject.due_date = Time.zone.now + 1.day
    subject.valid?
    expect(subject.errors.keys).to_not include :due_date
  end

  it_behaves_like 'paginatable concern', :coupon
end
