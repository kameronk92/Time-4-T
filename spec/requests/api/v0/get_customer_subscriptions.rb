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
    end
  end
end