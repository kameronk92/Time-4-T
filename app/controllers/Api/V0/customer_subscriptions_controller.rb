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

  def update
    customer_subscription = CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])

    if customer_subscription.nil?
      render json: { error: 'Customer Subscription not found' }, status: 404
    else
      customer_subscription.update(customer_subscription_params)
      render json: CustomerSubscriptionSerializer.new(customer_subscription), status: 200
    end
  end

  def index
    customer_subscriptions = CustomerSubscription.where(customer_id: params[:id])

    if customer_subscriptions.empty?
      render json: { error: 'Customer Subscriptions not found' }, status: 404
    else
      render json: CustomerSubscriptionSerializer.new(customer_subscriptions), status: 200
    end
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id, :status)
  end
end
