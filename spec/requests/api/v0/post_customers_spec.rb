require 'rails_helper'

RSpec.describe "Api::V0::Customers", type: :request do
  it "creates a customer" do
    customer_params = { customer: { first_name: 'John', last_name: 'Doe', email: 'fake@domain.com', address: '123 Fake St'} }

    post '/api/v0/customers/new', params: customer_params, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to have_key(:data)
    expect(data[:data]).to be_a(Hash)
    expect(data[:data]).to have_key(:id)
    expect(data[:data][:id]).to be_a(String)
    expect(data[:data]).to have_key(:type)
    expect(data[:data][:type]).to eq("customer")
    expect(data[:data]).to have_key(:attributes)

    attributes = data[:data][:attributes]
    expect(attributes).to have_key(:first_name)
    expect(attributes[:first_name]).to be_a(String)
    expect(attributes).to have_key(:last_name)
    expect(attributes[:last_name]).to be_a(String)
    expect(attributes).to have_key(:email)
    expect(attributes[:email]).to be_a(String)
    expect(attributes).to have_key(:address)
  end

  it "returns an error if any required fields are missing" do
    customer_params = { customer: { first_name: '', last_name: 'Doe', email: 'fake@domain.com', address: '123 Fake St', city: 'Fake City', state: 'Fake State', zip: '12345' } }

    post '/api/v0/customers/new', params: customer_params, as: :json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Customer could not be created. Please provide a first name, last name, email, and address.\"}")
  end

  it "returns an error if the user is not saved" do 
    customer_params = { customer: { first_name: 'John', last_name: 'Doe', email: 'fake@domain.com', address: '123 Fake St', city: 'Fake City', state: 'Fake State', zip: '12345' } }

    allow_any_instance_of(Customer).to receive(:save).and_return(false)

    post '/api/v0/customers/new', params: customer_params, as: :json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Customer could not be created; unknown error.\"}")
  end
end
