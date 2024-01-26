class Api::V0::CustomerSubscriptionsController < ApplicationController
  def create
    if Customer.find_by(id: params[:customer_id]).nil? || Subscription.find_by(id: params[:subscription_id]).nil?
      render json: { error: 'Customer or Subscription not found' }, status: 404
    elsif CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
      render json: { error: 'Customer Subscription already exists' }, status: 409
    else
      customer_subscription = CustomerSubscription.create(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
      render json: CustomerSubscriptionSerializer.new(customer_subscription), status: 201
    end
  end
end
