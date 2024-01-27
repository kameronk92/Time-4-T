class CreateCustomerSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_subscriptions do |t|

      t.timestamps
    end
  end
end
