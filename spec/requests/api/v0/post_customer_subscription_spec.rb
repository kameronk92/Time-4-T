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

  describe 'sad path' do
    it 'returns 404 if customer is not found' do
      subscription = create(:subscription)

      customer_subscription_params = { customer_id: 200, subscription_id: subscription.id }

      post "/api/v0/customers/200/subscription/#{subscription.id}", params: customer_subscription_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"error\":\"Customer or Subscription not found\"}")
    end

    it 'returns 404 if subscription is not found' do
      customer = create(:customer)

      customer_subscription_params = { customer_id: customer.id, subscription_id: 200 }

      post "/api/v0/customers/#{customer.id}/subscription/200", params: customer_subscription_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"error\":\"Customer or Subscription not found\"}")
    end

    it 'returns 409 if customer subscription already exists' do
      customer = create(:customer)
      subscription = create(:subscription)
      CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription.id)

      customer_subscription_params = { customer_id: customer.id, subscription_id: subscription.id }

      post "/api/v0/customers/#{customer.id}/subscription/#{subscription.id}", params: customer_subscription_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(409)
      expect(response.body).to eq("{\"error\":\"Customer Subscription already exists\"}")
    end
  end
end