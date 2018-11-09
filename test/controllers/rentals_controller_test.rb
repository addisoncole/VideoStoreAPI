require "test_helper"

describe RentalsController do
  let(:rental_data) {
     { "movie_id": movies(:goonies).id,
       "customer_id": customers(:sontag).id }
     }
  let(:bad_rental_data) {
    { "movie_id": 0, "customer_id": 0 }
    }

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status

    body = JSON.parse(response.body)

    expect(response.header['Content-Type']).must_include 'json'

    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "checkout" do

    it "creates new rental with valid request data" do


      expect {
        post checkout_path, params: rental_data, as: :json
      }.must_change('Rental.count', +1)

      body = check_response(expected_type: Hash)
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.movie_id).must_equal rental_data[:movie_id]
      expect(rental.customer_id).must_equal rental_data[:customer_id]
    end
    it "does not create new rental with invalid request data" do

      post checkout_path, params: bad_rental_data, as: :json
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "movie", "customer"
    end
    it "returns error message when movie out of stock" do
      inventory = movies(:goonies).inventory

      inventory.times do |i|
        post checkout_path, params: rental_data, as: :json
      end

      post checkout_path, params: rental_data, as: :json
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "movie_inventory"
    end
  end

  describe "checkin" do
    it "changes rental checked_in status to false with valid request data" do
      post checkout_path, params: rental_data, as: :json
      body = JSON.parse(response.body)
      rental = Rental.find(body["id"].to_i)
      expect(rental.checked_out?).must_equal true

      post checkin_path, params: rental_data, as: :json
      body = JSON.parse(response.body)
      rental = Rental.find(body["id"].to_i)
      expect(rental.checked_out?).must_equal false
      must_respond_with :success
    end
    it "returns error message with invalid request data" do
      post checkin_path, params: bad_rental_data, as: :json

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "rental"
    end
  end
end
