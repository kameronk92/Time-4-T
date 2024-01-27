class CreateSubscription < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.string :price
      t.string :status
      t.string :frequency

      t.timestamps
    end
  end
end
