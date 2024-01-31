# README

Time-4-T is a backend database application that contains linked customers, teas, and tea subscriptions. It follows guidelines on this [site](https://mod4.turing.edu/projects/take_home/take_home_be) to create 4 RESTful endpoints:
1. POST  /api/v0/customers/new
2. POST  /api/v0/customers/:id/subscription/:id
3. PUT  /api/v0/customers/:id/subscription/:id
4. GET  /api/v0/customers/:id/subscriptions

## To run this repository locally:
1. Fork and clone this repository
2. from the command line, run `bundle install` and `rails db:{drop,create,migrate,seed}`
3. run `bundle exec rspec`. You should see 18 passing tests.
4. run `rails s`. The backend application will now be running on `localhost:3000`

## Sample request/responses
Time-4-T uses serializers to return JSON in response to requests to the 4 endpoints listed above. Sample requests and *parsed* responses are provided below. 

No authorization is required for requests to this API. 

### POST  /api/v0/customers/new
#### Request: 
Requests to create a new customer must include the customer data in the request body, including first name, last name, email, and address. 

#### Response:
A successful response will contain the customer's ID and the attributes passed in the request. 
<img width="739" alt="post user image" src="https://github.com/kameronk92/Time-4-T/assets/138252060/d7f4f51d-aeb5-47d5-8c3e-4909971c8973">

### POST  /api/v0/customers/:id/subscription/:id
#### Request:
Requests to create a new user subscription must include the customer id and the subscription id in the body. Optionally, the subscription status can be passed as an enum ({ active: 0, paused: 1, cancelled: 2}). The default status is active. 

#### Response
A successful response will have a status code 201 and contain the customer subscription attributes, including the customer id, the subscription id, and the customer subscription status as a string. 

The response body will be in JSON format. A parsed example of a successful response body is shown below. 

```
{:data=>
  {:id=>"122",
   :type=>"customer_subscription",
   :attributes=>{:customer_id=>116, :subscription_id=>136, :status=>"active"}}}
```

### PUT /api/v0/customers/:id/subscription/:id
#### Request
Requests to *change* a customer subscription status should be sent to this endpoint, and optionally contain the desired updated status as an enum integer ({ active: 0, paused: 1, cancelled: 2}). Without an argument, the status will default to *active*.

#### Response
A successful response will have a status code 200 and contain the customer subscription attributes, including the customer id, the subscription id, and the customer subscription status as a string. 

The response body will be in JSON format. A parsed example of a successful response body is shown below. 

```
{:data=>
  {:id=>"128",
   :type=>"customer_subscription",
   :attributes=>{:customer_id=>122, :subscription_id=>143, :status=>"cancelled"}}}
```

### GET  /api/v0/customers/:id/subscriptions
#### Request
Requests to `GET` all customer subscriptions should be sent to this endpoint. A request body is not necessary. 

#### Response
A successful response will have a status code 200 and contain a collection of the customer's customer subscription attributes, including the customer id, the subscription id, and the customer subscription status as a string.

The response body will be in JSON format. A parsed example of a successful response body is shown below. 

```
{:data=>
  [{:id=>"113",
    :type=>"customer_subscription",
    :attributes=>{:customer_id=>113, :subscription_id=>127, :status=>"active"}},
   {:id=>"114",
    :type=>"customer_subscription",
    :attributes=>{:customer_id=>113, :subscription_id=>128, :status=>"active"}},
   {:id=>"115",
    :type=>"customer_subscription",
    :attributes=>{:customer_id=>113, :subscription_id=>129, :status=>"active"}}]}
```
