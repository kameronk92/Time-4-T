class ModifyCustomerSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :customer_subscriptions, :customer, null: false, foreign_key: true
    add_reference :customer_subscriptions, :subscription, null: false, foreign_key: true
  end
end
