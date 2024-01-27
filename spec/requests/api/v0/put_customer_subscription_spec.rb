require 'rails_helper'

RSpec.describe 'Customer Subscription Put Requests' do
  describe 'happy path' do
    it 'can update a customer subscription to cancelled' do
      customer = create(:customer)
      subscription = create(:subscription)
      customer_subscription = CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription.id)

      customer_subscription_params = { customer_id: customer.id, subscription_id: subscription.id, status: 2 }

      put "/api/v0/customers/#{customer.id}/subscription/#{subscription.id}", params: customer_subscription_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('customer_subscription')
      expect(json[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(json[:data][:attributes][:subscription_id]).to eq(subscription.id)
      expect(json[:data][:attributes][:status]).to eq('cancelled')
    end

    it 'can update a customer subscription to active' do
      customer = create(:customer)
      subscription = create(:subscription)
      customer_subscription = CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription.id, status: 2)

      customer_subscription_params = { customer_id: customer.id, subscription_id: subscription.id, status: 0 }

      put "/api/v0/customers/#{customer.id}/subscription/#{subscription.id}", params: customer_subscription_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('customer_subscription')
      expect(json[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(json[:data][:attributes][:subscription_id]).to eq(subscription.id)
      expect(json[:data][:attributes][:status]).to eq('active')
    end

    it 'can update a customer subscription to paused' do
      customer = create(:customer)
      subscription = create(:subscription)
      customer_subscription = CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription.id, status: 2)

      customer_subscription_params = { customer_id: customer.id, subscription_id: subscription.id, status: 1 }

      put "/api/v0/customers/#{customer.id}/subscription/#{subscription.id}", params: customer_subscription_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('customer_subscription')
      expect(json[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(json[:data][:attributes][:subscription_id]).to eq(subscription.id)
      expect(json[:data][:attributes][:status]).to eq('paused')
    end

    it 'returns a 404 if the customer subscription is not found' do
      customer = create(:customer)

      customer_subscription_params = { customer_id: customer.id, subscription_id: 200 }

      put "/api/v0/customers/#{customer.id}/subscription/200", params: customer_subscription_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"error\":\"Customer Subscription not found\"}")
    end
  end
end