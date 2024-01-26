require 'rails_helper'

RSpec.describe 'Customer Subscription API' do
  describe 'happy path' do
    it 'can create a customer subscription' do
      customer = create(:customer)
      subscription = create(:subscription)

      customer_subscription_params = { customer_id: customer.id, subscription_id: subscription.id }

      post "/api/v0/customers/#{customer.id}/subscription/#{subscription.id}", params: customer_subscription_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('customer_subscription')
      expect(json[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(json[:data][:attributes][:subscription_id]).to eq(subscription.id)
    end
  end
end