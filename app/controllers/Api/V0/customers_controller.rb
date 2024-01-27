class Api::V0::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)

    if customer_params[:first_name].empty? || customer_params[:last_name].empty? || customer_params[:email].empty? || customer_params[:address].empty?
      render json: { error: 'Customer could not be created. Please provide a first name, last name, email, and address.' }, status: :bad_request
    elsif customer.save
      render json: CustomerSerializer.new(customer), status: :created
    else
      render json: { error: 'Customer could not be created; unknown error.' }, status: :bad_request
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end
