require 'rails_helper'

RSpec.describe 'Customer Subscription Get Requests' do
  describe 'happy path' do
    it 'gets all subscriptions linked to a customer' do
      customer = create(:customer)
      subscriptions = create_list(:subscription, 3)
      customer.subscriptions << subscriptions

      get "/api/v0/customers/#{customer.id}/subscriptions" 

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:customer_id)
      expect(json[:data][0][:attributes][:customer_id]).to eq(customer.id)
      expect(json[:data][0][:attributes]).to have_key(:subscription_id)
      expect(json[:data][0][:attributes][:subscription_id]).to eq(subscriptions[0].id)
      expect(json[:data][0][:attributes]).to have_key(:status)
      expect(json[:data][0][:attributes][:status]).to eq('active') 
    end
  end

  describe 'sad path' do
    it 'returns 404 if customer subscriptions not found' do
      get "/api/v0/customers/1/subscriptions" 

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq('Customer Subscriptions not found')
    end
  end
end