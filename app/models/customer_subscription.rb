class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  enum :status, { active: 0, paused: 1, cancelled: 2}
end